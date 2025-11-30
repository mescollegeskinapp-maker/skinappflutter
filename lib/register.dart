import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
String baseUrl="http://192.168.1.40:5000";

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // ------------------ CONTROLLERS ------------------
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String? selectedGender;

  // ------------------ API CALL FUNCTION ------------------
 Future<void> userRegister(BuildContext context) async {
  final dio = Dio();

  final data = {
    "name": nameCtrl.text,
    "age": ageCtrl.text,
    "password": passwordCtrl.text,
    "confirm_password": confirmPasswordCtrl.text,
    "mobileno": mobileCtrl.text,
    "email": emailCtrl.text,
    "gender": selectedGender,
  };

  try {
    final response = await dio.post(
      "${baseUrl}UserReg_api/",   // <-- Corrected URL
      data: data,
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed: ${response.data}")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}


  // ------------------ UI ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RegisterPage')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            TextFormField(
              controller: nameCtrl,
              decoration: InputDecoration(
                label: const Text('Name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              controller: ageCtrl,
              decoration: InputDecoration(
                label: const Text('Age'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(
                label: const Text('Password'),
                suffixIcon: const Icon(Icons.visibility),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              controller: confirmPasswordCtrl,
              obscureText: true,
              decoration: InputDecoration(
                label: const Text('Confirm Password'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              controller: mobileCtrl,
              decoration: InputDecoration(
                label: const Text('Mobile No'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              controller: emailCtrl,
              decoration: InputDecoration(
                label: const Text('Email'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                label: const Text('Gender'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['male', 'female', 'others']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                selectedGender = value;
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 157, 203, 211),
                foregroundColor: const Color.fromARGB(255, 20, 19, 19),
              ),
              onPressed: () {
                userRegister(context);  // <<< CALL THE API FUNCTION
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
