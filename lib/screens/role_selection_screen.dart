import 'package:flutter/material.dart';
import 'package:jspm_connect/screens/form_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  List<String> roles = ["Student", "Faculty", "HOD"];
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

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen(selectedRole)),
            );
          },
        ),
      ),
    );
  }
}
