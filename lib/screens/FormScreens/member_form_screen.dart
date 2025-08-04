import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jspm_connect/models/member_model.dart';
import 'package:jspm_connect/screens/approval_screen.dart';
import 'package:jspm_connect/services/database/database.dart';
import 'package:jspm_connect/utils/app_btn.dart';
import 'package:jspm_connect/utils/app_input_field.dart';

class MemberFormScreen extends StatefulWidget {
  const MemberFormScreen({super.key});

  @override
  State<MemberFormScreen> createState() => _MemberFormScreenState();
}

class _MemberFormScreenState extends State<MemberFormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController picUrlController = TextEditingController();

  Map<String, bool> classes = {
    'SE-A': false,
    'SE-B': false,
    'TE-A': false,
    'TE-B': false,
    'BE-A': false,
    'BE-B': false,
  };

  String GFM = '';
  String? studentSelectedClass;

  void addMemberToFirebase() async {
    try {
      MemberModel member = MemberModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        name: nameController.text,
        email: FirebaseAuth.instance.currentUser!.email!,
        role: "Member",
        designation: designationController.text,
        department: departmentController.text,
        photoUrl: picUrlController.text,
        isApproved: false
      );
      Database db = Database();
      await db.initializeMembers(member);
      await db.updateFormFillStatus(true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Send approval request")));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ApprovalScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid input")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    departmentController.dispose();
    designationController.dispose();
    picUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "One time Form.",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                AppInputField(
                  hint: "Enter your name",
                  icon: CupertinoIcons.profile_circled,
                  obscureText: false,
                  controller: nameController,
                ),
                SizedBox(height: 10),

                AppInputField(
                  hint: "Your designation (ex. HOD)",
                  icon: Icons.face,
                  obscureText: false,
                  controller: designationController,
                ),

                SizedBox(height: 10),

                AppInputField(
                  hint: "department (ex. CSE, IT)",
                  icon: Icons.face,
                  obscureText: false,
                  controller: departmentController,
                ),

                SizedBox(height: 10),

                AppInputField(
                  hint: "Photo Url",
                  icon: Icons.face,
                  obscureText: false,
                  controller: picUrlController,
                ),

                SizedBox(height: 30),
                AppBtn(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  onTap: addMemberToFirebase,
                  child: Text("Continue"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
