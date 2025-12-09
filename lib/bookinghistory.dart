import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skinapp/login.dart';
import 'package:skinapp/register.dart';
import 'package:skinapp/viewprescription.dart';

class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  bool isLoading = true;
  List bookings = [];

  Future<void> fetchBookings() async {
    setState(() => isLoading = true);

    try {
      final response = await dio.get("$baseUrl/ViewBooking_api/$loginid");
      if (response.statusCode == 200) {
        bookings = response.data;
      }
    } catch (e) {
      print("Booking Error: $e");
    }

    setState(() => isLoading = false);
  }

  // ---------------------------------------------------------
  // CHECK PRESCRIPTION
  // ---------------------------------------------------------
  Future<void> checkPrescription(int bookingId) async {
    try {
      final response =
          await dio.get("$baseUrl/ViewPrescription_api/$bookingId");

      print(response.data);

      if (response.statusCode == 200 && response.data.length > 0) {
        // Prescription exists → Open detailed page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Viewprescription(
              prescription: response.data[0]["Prescription"],
            ),
          ),
        );
      } else {
        // No prescription found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No prescription added yet."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Prescription Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to load prescription."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),

      appBar: AppBar(
        title: const Text("Booking History"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : bookings.isEmpty
              ? Center(child: Text("No bookings found"))
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final b = bookings[index];

                    final doctor = b["DOCTORID"] ?? {};
                    final doctorName = doctor["name"] ?? "Doctor";
                    final hospital = doctor["hospitalname"] ?? "-";
                    final date = b["appoinmentdate"] ?? "";
                    final bookingId = b["id"];
                    final status = b["status"] ?? "Pending";

                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12, blurRadius: 6)
                        ],
                      ),
                      child: ListTile(
                        onTap: () => checkPrescription(bookingId),

                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Icon(Icons.person, color: Colors.white),
                        ),

                        title: Text(
                          doctorName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(hospital),
                            SizedBox(height: 4),
                            Text("Date: $date"),
                            SizedBox(height: 4),
                            Text(
                              status,
                              style: TextStyle(
                                color: status == "Pending"
                                    ? Colors.orange
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),

                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                ),
    );
  }
}
