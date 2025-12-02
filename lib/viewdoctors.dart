// import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skinapp/register.dart';

class Viewdoctors extends StatefulWidget {
  const Viewdoctors({super.key});

  @override
  State<Viewdoctors> createState() => _ViewdoctorsState();
}

class _ViewdoctorsState extends State<Viewdoctors> {

  bool isLoading = true;
  List<Map<String, dynamic>> doctors = [];
  Future<void> fetchDoctors() async {
  setState(() {
    isLoading = true;
  });

  try {
    
    final response = await dio.get("$baseUrl/ViewDoctor_api");

    print(response.data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        isLoading = false;
        doctors = List<Map<String, dynamic>>.from(response.data);
      });
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      isLoading = false;
    });
  }
}


  

  Future<void> _selectDateAndBook(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    bool? confirmBooking = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text("Confirm Booking"),
        content: Text(
          "Do you want to book this doctor on "
              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text("Confirm"),
          ),
        ],
      ),
    );

    if (confirmBooking != true) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text("Booking Successful"),
        content: Text(
          "Your booking has been confirmed for "
              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}.",
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            onPressed: () => Navigator.pop(ctx),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),

      body: isLoading
    ? Center(child: CircularProgressIndicator(color: Colors.teal))
    : doctors.isEmpty
        ? Center(child: Text("No doctors available"))
        : ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: doctors.length, 
        itemBuilder: (context, index) {
          final doctor=doctors[index];
          return Card(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [

                  // Profile Photo
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.teal.shade100,
                    child: Icon(Icons.person, size: 35, color: Colors.teal),
                  ),

                  SizedBox(width: 16),

                  // Doctor Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor['name'] ?? 'Doctor Name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text("Gender: ${doctor['gender'] ?? 'Not Specified'}"),
                        Text("Field: ${doctor['field'] ?? 'Not Specified'}"),
                        Text("Hospital: ${doctor['hospitalname'] ?? 'Not Specified'}"),
                        Text("Phone: ${doctor['mobileno'] ?? 'Not Specified'}"),
                      ],
                    ),
                  ),

                  // Request Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _selectDateAndBook(context),
                    child: Text("Book",style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
