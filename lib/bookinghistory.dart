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
    return  Scaffold(
      appBar: AppBar (title: Text('Booking History')),
      body: ListView.builder(
        itemCount:5 ,
        itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: const Color.fromARGB(255, 184, 181, 181),
            title: Text('Ravi'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('hospitalname'),
                Text('bookingh date'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Viewprescription(),));
                  },
                  child: Text('Prescription'),
                ),
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              color: Colors.yellow),child: Text('Pending'),),
          ),
        );
      },
      ));
  }
}