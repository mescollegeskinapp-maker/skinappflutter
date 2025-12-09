import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinapp/login.dart';
import 'package:skinapp/register.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  List medicines = [];
  bool isLoading = true;

  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMedicines();
  }

  // -------------------------------------------------------------
  // PICK IMAGE
  // -------------------------------------------------------------
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  // -------------------------------------------------------------
  // FETCH MEDICINES
  // -------------------------------------------------------------
  Future<void> fetchMedicines() async {
    setState(() => isLoading = true);

    try {
      final response = await dio.get("$baseUrl/ViewMedicine_api/$loginid");
      print("API Response: ${response.data}");

      if (response.statusCode == 200) {
        setState(() {
          medicines = response.data;
        });
      }
    } catch (e) {
      print("Fetch error: $e");
    }

    setState(() => isLoading = false);
  }

  // -------------------------------------------------------------
  // ADD MEDICINE
  // -------------------------------------------------------------
  Future<void> addMedicine() async {
    try {
      FormData data = FormData.fromMap({
        "MedicineName": nameController.text,
        "description": descriptionController.text,
        if (selectedImage != null)
          "prescriptionimage": await MultipartFile.fromFile(
            selectedImage!.path,
            filename: selectedImage!.path.split('/').last,
          ),
      });

      final response =
          await dio.post("$baseUrl/Addmedicine_api/$loginid", data: data);

      if (response.statusCode == 201) {
        fetchMedicines();
      }
    } catch (e) {
      print("Add error: $e");
    }
  }

  // -------------------------------------------------------------
  // EDIT MEDICINE
  // -------------------------------------------------------------
  Future<void> editMedicine(int id) async {
    try {
      FormData data = FormData.fromMap({
        "MedicineName": nameController.text,
        "description": descriptionController.text,
        if (selectedImage != null)
          "prescriptionimage": await MultipartFile.fromFile(
            selectedImage!.path,
            filename: selectedImage!.path.split('/').last,
          ),
      });

      final response =
          await dio.put("$baseUrl/EditMedicine_api/$id", data: data);

      if (response.statusCode == 200) {
        fetchMedicines();
      }
    } catch (e) {
      print("Edit error: $e");
    }
  }

  // -------------------------------------------------------------
  // DELETE MEDICINE
  // -------------------------------------------------------------
  Future<void> deleteMedicine(int id) async {
    try {
      final response = await dio.delete("$baseUrl/DeleteMedicine_api/$id");

      if (response.statusCode == 200) {
        fetchMedicines();
      }
    } catch (e) {
      print("Delete error: $e");
    }
  }

  // -------------------------------------------------------------
  // ADD / EDIT BOTTOM SHEET
  // -------------------------------------------------------------
  void openMedicineForm({Map? data}) {
    if (data != null) {
      nameController.text = data["MedicineName"] ?? "";
      descriptionController.text = data["description"] ?? "";
    } else {
      nameController.clear();
      descriptionController.clear();
    }

    selectedImage = null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data == null ? "Add Medicine" : "Edit Medicine",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Medicine Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),

              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),

              selectedImage != null
                  ? Image.file(selectedImage!, width: 150, height: 150)
                  : Container(
                      height: 120,
                      width: 120,
                      color: Colors.grey.shade300,
                      child: Icon(Icons.image, size: 50),
                    ),

              TextButton.icon(
                onPressed: pickImage,
                icon: Icon(Icons.image),
                label: Text("Choose Image"),
              ),

              ElevatedButton(
                onPressed: () {
                  if (data == null) {
                    addMedicine();
                  } else {
                    editMedicine(data["id"]);    // id IS CORRECT
                  }
                  Navigator.pop(context);
                },
                child: Text(data == null ? "Add" : "Update"),
              ),
            ],
          ),
        );
      },
    );
  }

  // -------------------------------------------------------------
  // CORRECT IMAGE URL BUILDER
  // -------------------------------------------------------------
  String buildImageUrl(dynamic imgPath) {
    if (imgPath == null) return "";

    String clean = imgPath.toString().trim();

    if (clean.startsWith("http")) return clean;

    // FIXED: remove extra /
    return "$baseUrl$clean".replaceAll("///", "/").replaceAll("//", "/").replaceFirst(":/", "://");
  }

  // -------------------------------------------------------------
  // UI
  // -------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine List"),
        backgroundColor: Colors.blue,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => openMedicineForm(),
        child: Icon(Icons.add),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : medicines.isEmpty
              ? Center(child: Text("No medicines found"))
              : ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final item = medicines[index];

                    final imgUrl = buildImageUrl('$baseUrl${item["prescriptionimage"]}');

                    print("Final Image URL: $imgUrl");

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: imgUrl.isNotEmpty
                            ? Image.network(
                                imgUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Icon(Icons.broken_image),
                              )
                            : Icon(Icons.medication, size: 40),

                        title: Text(item["MedicineName"] ?? "No Name"),
                        subtitle: Text(item["description"] ?? ""),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => openMedicineForm(data: item),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteMedicine(item["id"]),
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
