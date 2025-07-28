import 'package:flutter/material.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.lock_clock, size: 25)],
            ),
            SizedBox(height: 15),
            Text(
              "You can login once your request is approved",
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.inversePrimary.withOpacity(0.8),
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
