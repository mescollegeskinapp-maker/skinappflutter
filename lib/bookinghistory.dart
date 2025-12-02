// 
import 'package:flutter/material.dart';
import 'package:skinapp/viewprescription.dart';

class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),

      appBar: AppBar(
        title: const Text(
          'Booking History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),

      body: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Viewprescription()),
                );
              },

              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [

                    // Avatar
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 30),
                    ),

                    const SizedBox(width: 16),

                    // Info Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ravi",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.deepPurple.shade800,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: const [
                              Icon(Icons.local_hospital, size: 18, color: Colors.black54),
                              SizedBox(width: 6),
                              Text("City Hospital", style: TextStyle(fontSize: 14)),
                            ],
                          ),

                          const SizedBox(height: 4),

                          Row(
                            children: const [
                              Icon(Icons.calendar_today, size: 18, color: Colors.black54),
                              SizedBox(width: 6),
                              Text("Dec 14, 2024", style: TextStyle(fontSize: 14)),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "Pending",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Right Arrow
                    const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black54),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
