import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _selectedImage;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void uploadImage() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image")),
      );
      return;
    }

    // Replace this with your API upload logic
    print("Uploading image: ${_selectedImage!.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Photo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show selected image
            _selectedImage == null
                ? const Text("No Image Selected")
                : Image.file(
                    _selectedImage!,
                    height: 200,
                  ),

            const SizedBox(height: 20),

            // Pick Image Button
            ElevatedButton(
              onPressed: pickImage,
              child: const Text("Select Photo"),
            ),

            const SizedBox(height: 10),

            // Upload Button
            ElevatedButton(
              onPressed: uploadImage,
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
