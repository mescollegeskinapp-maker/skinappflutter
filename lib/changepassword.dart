// 
import 'package:flutter/material.dart';
import 'package:skinapp/login.dart';

import 'package:skinapp/register.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool oldPassVisible = false;
  bool newPassVisible = false;
  bool confirmPassVisible = false;

  final oldpassCtrl = TextEditingController();
  final newpassCtrl = TextEditingController();
  final confirmpassCtrl = TextEditingController();

  Future<void>ChangePassword(BuildContext context)async {
    final data= {
      "old_password":oldpassCtrl.text,
      "new_password":newpassCtrl.text,
      "confirm_password":confirmpassCtrl.text,
    };
    try {
      final response = await dio.post(
        "$baseUrl/ChangePassword_api/$loginid",
        data: data,
      );
print(response.data);
      if (response.statusCode == 201||response.statusCode==200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password change Successful!")),
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
      backgroundColor: const Color(0xfff3f4f6),

      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Old Password
                  TextFormField(controller: oldpassCtrl,
                    obscureText: !oldPassVisible,
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          oldPassVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() => oldPassVisible = !oldPassVisible);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 20),
              
                  // New Password
                  TextFormField(controller: newpassCtrl,
                    obscureText: !newPassVisible,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: const Icon(Icons.lock_reset),
                      suffixIcon: IconButton(
                        icon: Icon(
                          newPassVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() => newPassVisible = !newPassVisible);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 20),
              
                  // Confirm Password
                  TextFormField(controller: confirmpassCtrl,
                    obscureText: !confirmPassVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          confirmPassVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() => confirmPassVisible = !confirmPassVisible);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 30),
              
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () {
                        ChangePassword(context);
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
