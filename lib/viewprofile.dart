import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skinapp/changepassword.dart';
import 'package:skinapp/editprofile.dart';
import 'package:skinapp/login.dart';
import 'package:skinapp/register.dart';

// ✅ GLOBAL DIO INSTANCE
final Dio dio = Dio();



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;

  // ✅ PROFILE DATA (MAP — NOT LIST)
  Map<String, dynamic> userData = {
    "name": "Loading...",
    "age": "-",
    "mobileno": "-",
    "gender": "-",
    "email": "-",
  };

  @override
  void initState() {
    super.initState();
    ViewProfile_api();
  }

  Future<void> ViewProfile_api() async {
    try {
      final response =
          await dio.get("$baseUrl/ViewProfile_api/$loginid",);

      print("Profile API Response: ${response.data}");
      print("Response Type: ${response.data.runtimeType}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          userData = Map<String, dynamic>.from(response.data);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching profile: $e");
      setState(() {
        isLoading = false;
        userData["name"] = "Error loading profile";
      });
    }
  }

  // ✅ REUSABLE TILE
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F9),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("User Profile"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ✅ PROFILE AVATAR
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal,
                    child:
                        Icon(Icons.person, size: 60, color: Colors.white),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    userData["name"] ?? "N/A",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    userData["email"] ?? "N/A",
                    style: TextStyle(color: Colors.grey[700]),
                  ),

                  const SizedBox(height: 25),

                  // ✅ PROFILE DETAILS CARD
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
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        buildProfileTile(
                            Icons.badge, "Name", userData["name"] ?? "N/A"),
                        buildProfileTile(
                            Icons.cake, "Age", userData["age"] ?? "N/A"),
                        buildProfileTile(Icons.phone, "Mobile No",
                            userData["mobileno"].toString() ?? "N/A"),
                        buildProfileTile(Icons.person, "Gender",
                            userData["gender"] ?? "N/A"),
                        buildProfileTile(
                            Icons.email, "Email", userData["email"] ?? "N/A"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ✅ EDIT PROFILE BUTTON
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 28),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      "Edit Profile",
                      style:
                          TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () async {
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(userData: userData),
                        ),
                      );
                        ViewProfile_api();

                     
                        
                      
                    },
                  ),

                  // ✅ CHANGE PASSWORD
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePassword(),
                        ),
                      );
                    },
                    child: const Text(
                      "Change Password",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
