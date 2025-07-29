import 'package:flutter/material.dart';
import 'package:jspm_connect/screens/FormScreens/faculty_form_screen.dart';
import 'package:jspm_connect/screens/FormScreens/member_form_screen.dart';
import 'package:jspm_connect/screens/FormScreens/student_form_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  List<String> roles = ["Student", "Faculty", "Member"];
  String selectedRole = "Student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Role")),
      body: Center(
        child: DropdownButton<String>(
          value: selectedRole,
          items: roles
              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedRole = value!;
            });
            if (selectedRole == "Student") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentFormScreen()),
              );
            }

            if (selectedRole == "Faculty") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FacultyFormScreen()),
              );
            }

            if (selectedRole == "Member") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberFormScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}
