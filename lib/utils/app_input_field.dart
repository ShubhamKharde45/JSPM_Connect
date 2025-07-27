import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.hint,
    required this.icon,
    required this.obscureText,
    this.controller,
    this.width,
    this.height
  });
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextEditingController? controller;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 65,
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorHeight: 25,
        showCursor: true,
        cursorColor: Theme.of(context).colorScheme.inversePrimary,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          hintStyle: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.inversePrimary.withOpacity(0.8),
          ),
          prefixIcon: Icon(
            icon,
            color: Theme.of(
              context,
            ).colorScheme.inversePrimary.withOpacity(0.8),
          ),
          fillColor: Theme.of(context).colorScheme.primary,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
