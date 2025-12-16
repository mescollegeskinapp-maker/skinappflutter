// import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String baseUrl ="http://192.168.1.84:5000";
final dio = Dio();

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String? selectedGender;

  Future<void> userRegister(BuildContext context) async {
    

    final data = {
      "name": nameCtrl.text,
      "age": ageCtrl.text,
      "username":emailCtrl.text,
      "password": confirmPasswordCtrl.text,
      // "confirm_password": confirmPasswordCtrl.text,
      "mobileno": mobileCtrl.text,
      "email": emailCtrl.text,
      "gender": selectedGender,
    };

    try {
      final response = await dio.post(
        "$baseUrl/UserReg_api",
        data: data,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful!")),
        );
        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                    blurRadius: 8, color: Colors.black12, offset: Offset(0, 3))
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 20),

                _buildTextField("Name", nameCtrl, Icons.person),
                _buildTextField("Age", ageCtrl, Icons.cake),
                _buildTextField("Mobile No", mobileCtrl, Icons.phone),
                _buildTextField("Email", emailCtrl, Icons.email),

                _buildPasswordField("Password", passwordCtrl),
                _buildPasswordField("Confirm Password", confirmPasswordCtrl),

                const SizedBox(height: 10),

                DropdownButtonFormField(
                  decoration: _inputDecoration("Gender"),
                  items: ['male', 'female', 'others']
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) => selectedGender = value,
                ),

                const SizedBox(height: 25),

                Center(
                  child: GestureDetector(
                    onTap: () => userRegister(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.blueAccent],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable TextField
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: _inputDecoration(label).copyWith(prefixIcon: Icon(icon)),
      ),
    );
  }

  // Password Field
  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: _inputDecoration(label).copyWith(
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: const Icon(Icons.visibility),
        ),
      ),
    );
  }

  // Input Decoration
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: const Color(0xFFF0F3F7),
    );
  }
}
