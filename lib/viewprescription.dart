import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Viewprescription extends StatelessWidget {
  final String prescription;

  const Viewprescription({super.key, required this.prescription});
Future<bool> requestStoragePermission() async {
  if (Platform.isAndroid) {
    // Android 13+ (API 33+)
    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    }

    // Request FULL STORAGE access (needed for Downloads folder)
    var status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }

  return false;
}

  Future<void> downloadPrescription(BuildContext context) async {

  bool allowed = await requestStoragePermission();
  if (!allowed) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Storage permission denied")),
    );
    return;
  }

  Directory directory = Directory("/storage/emulated/0/Download");

  if (!directory.existsSync()) {
    directory = (await getExternalStorageDirectory())!;
  }

  String filePath = "${directory.path}/Prescription.txt";
  File file = File(filePath);

  await file.writeAsString(prescription);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Downloaded to: $filePath")),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescription"),
        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prescription",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  prescription,
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: () => downloadPrescription(context),
                    icon: Icon(Icons.download),
                    label: Text("Download"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
