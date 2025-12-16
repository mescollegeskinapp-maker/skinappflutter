import 'package:flutter/material.dart';
import 'package:skinapp/bookinghistory.dart';
import 'package:skinapp/feedback.dart';
import 'package:skinapp/image.dart';
import 'package:skinapp/managemedicine.dart';
import 'package:skinapp/viewdoctors.dart';
import 'package:skinapp/viewprofile.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👋 Welcome Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome back 👋',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage your health activities easily',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 📊 Dashboard Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                children: [
                  _dashboardTile(
                    context,
                    title: 'Booking History',
                    icon: Icons.history,
                    colors: [Color(0xff6A5AE0), Color(0xff8E8BFF)],
                    route: Bookinghistory(),
                  ),
                  _dashboardTile(
                    context,
                    title: 'Profile',
                    icon: Icons.person_outline,
                    colors: [Color(0xff00BFA6), Color(0xff4DD0C8)],
                    route: ProfileScreen(),
                  ),
                  _dashboardTile(
                    context,
                    title: 'View Doctors',
                    icon: Icons.medical_services_outlined,
                    colors: [Color(0xff2196F3), Color(0xff64B5F6)],
                    route: Viewdoctors(),
                  ),
                  _dashboardTile(
                    context,
                    title: 'Feedback',
                    icon: Icons.feedback_outlined,
                    colors: [Color(0xffFF9800), Color(0xffFFB74D)],
                    route: FeedbackPage(),
                  ),
                  _dashboardTile(
                    context,
                    title: 'Image Upload',
                    icon: Icons.cloud_upload_outlined,
                    colors: [Color(0xff43A047), Color(0xff81C784)],
                    route: ImageUpload(),
                  ),
                  _dashboardTile(
                    context,
                    title: 'Medicine',
                    icon: Icons.medication_outlined,
                    colors: [Color(0xffE53935), Color(0xffEF5350)],
                    route: MedicinePage(),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      borderRadius: BorderRadius.circular(20),
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
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
