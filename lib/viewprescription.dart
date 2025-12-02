// import 'package:flutter/material.dart';

// class Viewprescription extends StatefulWidget {
//   const Viewprescription({super.key});

//   @override
//   State<Viewprescription> createState() => _ViewprescriptionState();
// }

// class _ViewprescriptionState extends State<Viewprescription> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       // appBar: AppBar (title: Text('View Prescription')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: const Color.fromARGB(96, 180, 174, 174),),
//             height: 200,
//             width: double.infinity,
//             child: Column(
//               // mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text('Prescription:',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),),
//                 Text('gfvasxhb jcsbskj kjcbkjscs'),
                
//                 Text('Date:', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),),
//                 Text('25/11/2025')
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class Viewprescription extends StatefulWidget {
  const Viewprescription({super.key});

  @override
  State<Viewprescription> createState() => _ViewprescriptionState();
}

class _ViewprescriptionState extends State<Viewprescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prescription"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Card(
          elevation: 5,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

          child: Padding(
            padding: const EdgeInsets.all(20.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                // Header
                Row(
                  children: [
                    Icon(Icons.receipt_long, size: 28, color: Colors.teal),
                    SizedBox(width: 10),
                    Text(
                      "Prescription Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),

                // Prescription Text
                Text(
                  "Prescription:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "Take 1 tablet of Paracetamol before sleep.\nDrink plenty of water.\nFollow-up in 1 week.",
                  style: TextStyle(fontSize: 15, height: 1.4),
                ),

                SizedBox(height: 20),

                // Date
                Text(
                  "Date:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "25 / 11 / 2025",
                  style: TextStyle(fontSize: 15),
                ),

                SizedBox(height: 26),

                // Download Button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Your download logic here
                    },
                    icon: Icon(Icons.download),
                    label: Text("Download"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
