// import 'package:flutter/material.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('LoginPage',style: TextStyle(color:Color.fromARGB(255, 13, 29, 31)),),
//         backgroundColor: const Color.fromARGB(255, 154, 167, 174),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: .center,
//             spacing: 10,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(label: Text('username'),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12)
//                   )
//                 ),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(label: Text('password'),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12)
//                 )
          
          
          
//                 )
//               ),
//               SizedBox(height: 10,),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 157, 203, 211),foregroundColor: const Color.fromARGB(255, 20, 19, 19)),
//                 onPressed: (){}, child: Text('Login'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skinapp/forgotpassword.dart';
import 'package:skinapp/home.dart';
import 'package:skinapp/register.dart';

int? loginid;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  Future<void> Login(BuildContext context) async {
    final dio = Dio();

    final data = {
      
      
      "username":emailCtrl.text,
      "password": passwordCtrl.text,
      // "confirm_password": confirmPasswordCtrl.text,
      
    };

    try {
      final response = await dio.post(
        "$baseUrl/LoginPage_api",
        data: data,
      );

      if (response.statusCode == 201 || response.statusCode ==200) {

        loginid=response.data['login_id'];
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful!")),
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),),(route)=>false);
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
      backgroundColor: const Color(0xFFEFF3F6),
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Color(0xFF0D1D1F),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF9AA7AE),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Color(0xFF6A7C85),
                ),

                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B3A42),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please login to continue",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6A7C85),
                  ),
                ),
                const SizedBox(height: 30),

                // Username Input
                TextFormField(controller: emailCtrl,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                // Password Input
                TextFormField(controller: passwordCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpassword(),));
                    }, child: Text('Forgot Password?', style: TextStyle(color: Colors.black),))
                  ],
                ),
                const SizedBox(height: 20),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7BB6C2),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Login(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Optional: Sign up text
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                  },
                  child: const Text(
                    "Create an account",
                    style: TextStyle(
                      color: Color(0xFF4A6E78),
                      fontWeight: FontWeight.bold,
                    ),
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
