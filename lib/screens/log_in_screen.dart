import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/screens/sign_up_screen.dart';
import 'package:jspm_connect/services/auth/auth.dart';
import 'package:jspm_connect/services/auth/auth_screen.dart';
import 'package:jspm_connect/utils/app_btn.dart';
import 'package:jspm_connect/utils/app_input_field.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;

  Future<void> handleLogin() async {
    setState(() => isLoading = true);

    try {
      final auth = Auth();
      await auth.logIn(
        emailController.text.trim(),
        passController.text.trim(),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AuthScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.lock, size: 35),
                const SizedBox(height: 30),
                Text(
                  "Welcome to JSPM Connect",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Your data is safe",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.6),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 40),
                AppInputField(
                  hint: "Email",
                  icon: Icons.email,
                  obscureText: false,
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                AppInputField(
                  hint: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  controller: passController,
                ),
                const SizedBox(height: 20),
                AppBtn(
                  onTap: isLoading ? null : handleLogin,
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Log In"),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.6),
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
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
      ),
    );
  }
}
