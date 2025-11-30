import 'package:flutter/material.dart';
import 'package:skinapp/bookinghistory.dart';
import 'package:skinapp/feedback.dart';
import 'package:skinapp/image.dart';
import 'package:skinapp/login.dart';
import 'package:skinapp/register.dart';
import 'package:skinapp/viewdoctors.dart';
import 'package:skinapp/viewprescription.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ImageUpload()
    );
  }
}

