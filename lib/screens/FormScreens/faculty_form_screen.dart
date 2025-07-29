import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jspm_connect/models/faculty_model.dart';

import 'package:jspm_connect/screens/approval_screen.dart';
import 'package:jspm_connect/services/database/database.dart';
import 'package:jspm_connect/utils/app_btn.dart';
import 'package:jspm_connect/utils/app_container.dart';
import 'package:jspm_connect/utils/app_input_field.dart';

class FacultyFormScreen extends StatefulWidget {
  const FacultyFormScreen({super.key});

  @override
  State<FacultyFormScreen> createState() => _FacultyFormScreenState();
}

class _FacultyFormScreenState extends State<FacultyFormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController picUrlController = TextEditingController();
  TextEditingController gfmController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

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
      FacultyModel faculty = FacultyModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        name: nameController.text,
        email: FirebaseAuth.instance.currentUser!.email!,
        department: departmentController.text,
        designation: designationController.text,
        gfm: gfmController.text,
        classes: classes,
        role: "Faculty",
        photoUrl: picUrlController.text,
        taughtSubject: subjectController.text,
        isApproved: false,
      );

      Database db = Database();
      await db.initializeFaculty(faculty);
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
                AppContainer(
                  child: AppInputField(
                    hint: "Enter your name",
                    icon: CupertinoIcons.profile_circled,
                    obscureText: false,
                    controller: nameController,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select class you teach",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      ListView(
                        shrinkWrap: true,
                        children: classes.keys
                            .map(
                              (e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(e),
                                  Checkbox(
                                    activeColor: Theme.of(
                                      context,
                                    ).colorScheme.inversePrimary,
                                    value: classes[e],
                                    onChanged: (value) {
                                      setState(() {
                                        classes[e] = !classes[e]!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                AppInputField(
                  hint: "Your designation (ex. Faculty)",
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
                  hint: "Subject (ex. Math3)",
                  icon: Icons.face,
                  obscureText: false,
                  controller: subjectController,
                ),

                SizedBox(height: 10),

                AppInputField(
                  hint: "Photo Url",
                  icon: Icons.face,
                  obscureText: false,
                  controller: picUrlController,
                ),

                SizedBox(height: 10),
                AppInputField(
                  hint: "GFM (ex. SE-A2)",
                  icon: Icons.face,
                  obscureText: false,
                  controller: gfmController,
                ),

                SizedBox(height: 30),
                AppBtn(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  onTap: addStudentToFirebase,
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
