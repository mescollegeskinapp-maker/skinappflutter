import 'package:flutter/material.dart';

class Viewprescription extends StatefulWidget {
  const Viewprescription({super.key});

  @override
  State<Viewprescription> createState() => _ViewprescriptionState();
}

class _ViewprescriptionState extends State<Viewprescription> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar (title: Text('View Prescription')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(96, 180, 174, 174),),
            height: 200,
            width: double.infinity,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Prescription:',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),),
                Text('gfvasxhb jcsbskj kjcbkjscs'),
                
                Text('Date:', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),),
                Text('25/11/2025')
              ],
            ),
          ),
        ),
      ),
    );
  }
}