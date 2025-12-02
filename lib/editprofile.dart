// import 'package:flutter/material.dart';

// class EditProfileScreen extends StatefulWidget {
//   final Map<String, dynamic> userData;

//   const EditProfileScreen({super.key, required this.userData});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   late TextEditingController nameCtrl;
//   late TextEditingController ageCtrl;
//   late TextEditingController mobileCtrl;
//   late TextEditingController genderCtrl;
//   late TextEditingController emailCtrl;

//   @override
//   void initState() {
//     super.initState();

//     nameCtrl = TextEditingController(text: widget.userData["name"]);
//     ageCtrl = TextEditingController(text: widget.userData["age"]);
//     mobileCtrl = TextEditingController(text: widget.userData["mobileno"]);
//     genderCtrl = TextEditingController(text: widget.userData["gender"]);
//     emailCtrl = TextEditingController(text: widget.userData["email"]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F7FB),
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text("Edit Profile"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: ListView(
//           children: [
//             buildTextField("Name", nameCtrl),
//             buildTextField("Age", ageCtrl),
//             buildTextField("Mobile No", mobileCtrl),
//             buildTextField("Gender", genderCtrl),
//             buildTextField("Email", emailCtrl),

//             const SizedBox(height: 30),

//             ElevatedButton(
//               onPressed: () {
//                 Map<String, dynamic> updatedUser = {
//                   "name": nameCtrl.text,
//                   "age": ageCtrl.text,
//                   "mobileno": mobileCtrl.text,
//                   "gender": genderCtrl.text,
//                   "email": emailCtrl.text,
//                 };

//                 Navigator.pop(context, updatedUser);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//               child: const Text(
//                 "Save Changes",
//                 style: TextStyle(fontSize: 16),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 18),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController ageCtrl;
  late TextEditingController mobileCtrl;
  late TextEditingController genderCtrl;
  late TextEditingController emailCtrl;

  @override
  void initState() {
    super.initState();

    nameCtrl = TextEditingController(text: widget.userData["name"]);
    ageCtrl = TextEditingController(text: widget.userData["age"]);
    mobileCtrl = TextEditingController(text: widget.userData["mobileno"]);
    genderCtrl = TextEditingController(text: widget.userData["gender"]);
    emailCtrl = TextEditingController(text: widget.userData["email"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),

      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: ListView(
              shrinkWrap: true,
              children: [
                buildTextField("Name", nameCtrl, Icons.person),
                buildTextField("Age", ageCtrl, Icons.calendar_today),
                buildTextField("Mobile No", mobileCtrl, Icons.phone_android),
                buildTextField("Gender", genderCtrl, Icons.people),
                buildTextField("Email", emailCtrl, Icons.email_outlined),
                const SizedBox(height: 20),

                // Save Button
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Colors.deepPurple, Colors.blueAccent],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> updatedUser = {
                        "name": nameCtrl.text,
                        "age": ageCtrl.text,
                        "mobileno": mobileCtrl.text,
                        "gender": genderCtrl.text,
                        "email": emailCtrl.text,
                      };

                      Navigator.pop(context, updatedUser);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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

  Widget buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          labelStyle: const TextStyle(fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
    );
  }
}
