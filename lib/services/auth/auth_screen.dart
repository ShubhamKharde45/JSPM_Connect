import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/screens/FormScreens/faculty_form_screen.dart';
import 'package:jspm_connect/screens/FormScreens/member_form_screen.dart';
import 'package:jspm_connect/screens/FormScreens/student_form_screen.dart';
import 'package:jspm_connect/screens/log_in_screen.dart';
import 'package:jspm_connect/screens/main_screen.dart';
import 'package:jspm_connect/screens/approval_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  Future<Widget> handleUserRedirect(User user) async {
    final uid = user.uid;
    final doc = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    final data = doc.data();

    if (data == null) return const LogInScreen();

    final isFormFilled = data['isFormField'] == true;
    final isVerified = data['isVarified'] == true;

    if (!isFormFilled) {
      final role = data['role'];
      if (role == 'Student') return const StudentFormScreen();
      if (role == 'Faculty') return const FacultyFormScreen();
      if (role == 'Member') return const MemberFormScreen();
    }

    if (!isVerified) return  ApprovalScreen();

    return const MainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Something went wrong.\n${snapshot.error}"),
            ),
          );
        }

        final user = snapshot.data;
        if (user == null) return const LogInScreen();

        return FutureBuilder<Widget>(
          future: handleUserRedirect(user),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return snapshot.data!;
          },
        );
      },
    );
  }
}
