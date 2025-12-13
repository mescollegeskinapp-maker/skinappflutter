import 'package:flutter/material.dart';
import 'package:skinapp/bookinghistory.dart';
import 'package:skinapp/feedback.dart';
import 'package:skinapp/image.dart';
import 'package:skinapp/managemedicine.dart';
import 'package:skinapp/viewdoctors.dart';
import 'package:skinapp/viewprofile.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF1F6),
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1,
          ),
          children: [
            _dashboardTile(
              context,
              title: 'Booking History',
              icon: Icons.history,
              colors: [Colors.deepPurple, Colors.purpleAccent],
              route: Bookinghistory(),
            ),
            _dashboardTile(
              context,
              title: 'Profile',
              icon: Icons.person,
              colors: [Colors.teal, Colors.green],
              route: ProfileScreen(),
            ),
            _dashboardTile(
              context,
              title: 'View Doctor',
              icon: Icons.medical_services,
              colors: [Colors.blue, Colors.lightBlueAccent],
              route: Viewdoctors(),
            ),
            _dashboardTile(
              context,
              title: 'Feedback',
              icon: Icons.feedback,
              colors: [Colors.orange, Colors.deepOrange],
              route: FeedbackPage(),
            ),
            _dashboardTile(
              context,
              title: 'Image Upload',
              icon: Icons.cloud_upload,
              colors: [Colors.green, Colors.teal],
              route: ImageUpload(),
            ),
            _dashboardTile(
              context,
              title: 'Medicine',
              icon: Icons.medication,
              colors: [Colors.redAccent, Colors.pink],
              route: MedicinePage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Color> colors,
    required Widget route,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => route),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 46, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
