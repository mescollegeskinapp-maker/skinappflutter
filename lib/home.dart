import 'package:flutter/material.dart';
import 'package:skinapp/bookinghistory.dart';
import 'package:skinapp/feedback.dart';
import 'package:skinapp/image.dart';
import 'package:skinapp/managemedicine.dart';
import 'package:skinapp/viewdoctors.dart';
import 'package:skinapp/viewprofile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildHomeButton(
              context,
              title: 'Booking History',
              icon: Icons.history,
              route: Bookinghistory(),
            ),
            _buildHomeButton(
              context,
              title: 'Profile',
              icon: Icons.person,
              route: ProfileScreen(),
            ),
            _buildHomeButton(
              context,
              title: 'View Doctor',
              icon: Icons.medical_information,
              route: Viewdoctors(),
            ),
            _buildHomeButton(
              context,
              title: 'Feedback',
              icon: Icons.feedback,
              route: FeedbackPage(),
            ),
            _buildHomeButton(
              context,
              title: 'Image Upload',
              icon: Icons.upload_file,
              route: ImageUpload(),
            ),
            _buildHomeButton(
              context,
              title: 'Manage Medicine',
              icon: Icons.medication,
              route: MedicinePage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context, {
    required String title,
    required IconData icon,
    required Widget route,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => route, // Replace with actual screen
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
