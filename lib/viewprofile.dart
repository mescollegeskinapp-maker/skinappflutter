// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:skinapp/changepassword.dart';
import 'package:skinapp/editprofile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {
    "name": "John Doe",
    "age": "25",
    "mobileno": "9876543210",
    "gender": "Male",
    "email": "john@gmail.com",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F9),

      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text("User Profile"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Profile Avatar
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userData["name"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userData["email"],
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Main Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),

              child: Column(
                children: [
                  buildProfileTile(Icons.badge, "Name", userData["name"]),
                  buildProfileTile(Icons.cake, "Age", userData["age"]),
                  buildProfileTile(Icons.phone, "Mobile No", userData["mobileno"]),
                  buildProfileTile(Icons.person_3, "Gender", userData["gender"]),
                  buildProfileTile(Icons.email, "Email", userData["email"]),
                ],
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () async {
                var updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProfileScreen(userData: userData),
                  ),
                );

                if (updatedData != null) {
                  setState(() {
                    userData = updatedData;
                  });
                }
              },
              label: const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(),));
            }, child: Text('Change Password', style: TextStyle(color: Colors.black),))
          ],
        ),
      ),
    );
  }

  // Reusable tile widget
  Widget buildProfileTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 12),
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
