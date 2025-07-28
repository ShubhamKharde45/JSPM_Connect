import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/screens/log_in_screen.dart';
import 'package:jspm_connect/services/auth/auth.dart';
import 'package:jspm_connect/utils/app_btn.dart';
import 'package:jspm_connect/utils/app_input_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  void createAccount() async {
    Auth auth = Auth();
    try {
      if (passController.text.trim() != confirmPassController.text.trim()) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Password does not match")));
      } else {
        await auth.createUser(
          emailController.text.trim(),
          passController.text.trim(),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("You can login now!")));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen(true)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.lock, size: 35),
              SizedBox(height: 30),
              Text(
                "Let's join to JSPM Connect.",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "You'r data is safe",
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.inversePrimary.withOpacity(0.6),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 50),
              AppInputField(
                hint: "Email",
                icon: Icons.email,
                obscureText: false,
                controller: emailController,
              ),
              SizedBox(height: 10),
              AppInputField(
                hint: "Password",
                icon: Icons.password,
                obscureText: true,
                controller: passController,
              ),
              SizedBox(height: 10),
              AppInputField(
                hint: "Confirm password",
                icon: Icons.password,
                obscureText: true,
                controller: confirmPassController,
              ),
              SizedBox(height: 20),
              AppBtn(
                onTap: () => createAccount(),
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text("Create account"),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ? ",
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.inversePrimary.withOpacity(0.5),
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogInScreen(false),
                        ),
                      );
                    },
                    child: Text(
                      "Login here.",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
