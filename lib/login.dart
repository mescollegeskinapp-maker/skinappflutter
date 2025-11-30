import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage',style: TextStyle(color:Color.fromARGB(255, 13, 29, 31)),),
        backgroundColor: const Color.fromARGB(255, 154, 167, 174),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: 10,
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text('username'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('password'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
          
          
          
                )
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 157, 203, 211),foregroundColor: const Color.fromARGB(255, 20, 19, 19)),
                onPressed: (){}, child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}