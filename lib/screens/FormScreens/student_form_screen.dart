import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jspm_connect/models/student_model.dart';
import 'package:jspm_connect/screens/approval_screen.dart';
import 'package:jspm_connect/services/database/database.dart';
import 'package:jspm_connect/utils/app_btn.dart';
import 'package:jspm_connect/utils/app_container.dart';
import 'package:jspm_connect/utils/app_input_field.dart';

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController picController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController gfmController = TextEditingController();

  String? studentSelectedClass;

  Map<String, bool> classes = {
    'SE-A': false,
    'SE-B': false,
    'TE-A': false,
    'TE-B': false,
    'BE-A': false,
    'BE-B': false,
  };

  void addStudentToFirebase() async {
    try {
      StudentModel student = StudentModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        name: nameController.text.toString(),
        email: FirebaseAuth.instance.currentUser!.email!,
        department: departmentController.text,
        year: studentSelectedClass!.substring(0, 2),
        role: "Student",
        photoUrl: picController.text,
        gfm: gfmController.text,
        isApproved: false,
      );
      Database db = Database();
      await db.initializeStudent(student);
      
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Send approval request")));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ApprovalScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid input")));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> studentClasses = classes.keys.toList();
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

                AppContainer(
                  child: AppInputField(
                    hint: "Enter your name",
                    icon: CupertinoIcons.profile_circled,
                    obscureText: false,
                    controller: nameController,
                  ),
                ),
                AppContainer(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Select your class",
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.inversePrimary.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      DropdownButton<String>(
                        value: studentSelectedClass,
                        items: studentClasses
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            studentSelectedClass = value ?? "SE-A";
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                AppInputField(
                  hint: "department (ex. CSE)",
                  icon: Icons.face,
                  obscureText: false,
                  controller: departmentController,
                ),

                SizedBox(height: 10),
                AppInputField(
                  hint: "GFM Batch(ex. SE-A2)",
                  icon: Icons.face,
                  obscureText: false,
                  controller: gfmController,
                ),

                SizedBox(height: 10),
                AppInputField(
                  hint: "photoUrl",
                  icon: Icons.face,
                  obscureText: false,
                  controller: picController,
                ),

                SizedBox(height: 30),
                AppBtn(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  onTap: addStudentToFirebase,
                  child: Text(
                    "Request approval",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
