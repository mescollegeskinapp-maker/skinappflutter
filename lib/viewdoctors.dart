import 'package:flutter/material.dart';

class Viewdoctors extends StatefulWidget {
  const Viewdoctors({super.key});

  @override
  State<Viewdoctors> createState() => _ViewdoctorsState();
}

class _ViewdoctorsState extends State<Viewdoctors> {

  Future<void> _selectDateAndBook(BuildContext context) async {
    // Step 1: Open DatePicker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return; // user canceled

    // Step 2: Ask for confirmation
    bool? confirmBooking = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Confirm Booking"),
        content: Text("Do you want to book this doctor on "
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text("Confirm"),
          ),
        ],
      ),
    );

    if (confirmBooking != true) return;

    // Step 3: Show booking success dialog
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Booking Successful"),
        content: Text("Your booking has been confirmed for "
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}."),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Viewdoctor')),
      body: ListView.builder(
        itemCount: 5, // demo
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: const Color.fromARGB(255, 184, 181, 181),
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text(
                'Ravi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Gender'),
                  Text('Field'),
                  Text('Hospital'),
                  Text('Mobile no'),
                ],
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))),
                onPressed: () => _selectDateAndBook(context),
                child: Text('Send Request'),
              ),
            ),
          );
        },
      ),
    );
  }
}
