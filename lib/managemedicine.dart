// import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  List<Map<String, dynamic>> medicines = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  // Pick Image
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  // Add or Edit Medicine (Bottom Sheet UI)
  void openMedicineForm({Map<String, dynamic>? data, int? index}) {
    if (data != null) {
      nameController.text = data["medicineName"];
      descriptionController.text = data["description"];
      selectedImage = data["image"];
    } else {
      nameController.clear();
      descriptionController.clear();
      selectedImage = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  data == null ? "Add Medicine" : "Edit Medicine",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Medicine Name
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Medicine Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Description
                TextField(
                  controller: descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Image preview
                selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          selectedImage!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                            child: Icon(Icons.image, size: 60, color: Colors.grey)),
                      ),

                const SizedBox(height: 10),

                // Pick Image
                ElevatedButton.icon(
                  onPressed: pickImage,
                  icon: Icon(Icons.photo),
                  label: Text("Pick Image"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final newData = {
                        "medicineName": nameController.text,
                        "description": descriptionController.text,
                        "image": selectedImage,
                        "date": DateTime.now().toString().split(' ')[0],
                      };

                      if (data == null) {
                        medicines.add(newData);
                      } else {
                        medicines[index!] = newData;
                      }

                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text("Save", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // Delete Medicine
  void deleteMedicine(int index) {
    setState(() {
      medicines.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      appBar: AppBar(
        title: Text("Medicine List"),
        backgroundColor: Colors.blue,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => openMedicineForm(),
        child: Icon(Icons.add, size: 30),
      ),

      body: medicines.isEmpty
          ? Center(
              child: Text(
                "No medicines added yet",
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final item = medicines[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: item["image"] != null
                          ? Image.file(
                              item["image"],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.medication, size: 40),
                    ),
                    title: Text(
                      item["medicineName"],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${item["description"]}\n📅 Date: ${item["date"]}",
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              openMedicineForm(data: item, index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteMedicine(index),
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
