
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/screens/main_screen.dart';
import 'package:jspm_connect/screens/role_selection_screen.dart';
import 'package:jspm_connect/screens/sign_up_screen.dart';
import 'package:jspm_connect/services/auth/auth.dart';
import 'package:jspm_connect/utils/app_btn.dart';
import 'package:jspm_connect/utils/app_input_field.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen(this.isNewAccount, {super.key});

  final bool isNewAccount;

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
                "Welcome to JSPM Connect",
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
              SizedBox(height: 20),
              AppBtn(
                onTap: () async {
                  Auth auth = Auth();
                  try {
                    await auth.logIn(
                      emailController.text.trim(),
                      passController.text.trim(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Welcome back to JSPM Connect !")),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if (widget.isNewAccount) {
                            return RoleSelectionScreen();
                          } 
                          return MainScreen();
                        },
                      ),
                      (route) => false,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text("LogIn"),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account ? ",
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
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      "Create here.",
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
