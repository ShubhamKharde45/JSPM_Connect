import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/screens/approval_screen.dart';
import 'package:jspm_connect/utils/app_btn.dart';
import 'package:jspm_connect/utils/app_container.dart';
import 'package:jspm_connect/utils/app_input_field.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen(this.role, {super.key});

  final String role;

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  Map<String, bool> classes = {
    'SE-A': false,
    'SE-B': false,
    'TE-A': false,
    'TE-B': false,
    'BE-A': false,
    'BE-B': false,
  };

  String GFM = '';

  // STUDENT
  String? studentSelectedClass;

  @override
  Widget build(BuildContext context) {
    if (widget.role == "Faculty") {
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
                  AppInputField(
                    hint: "GFM (ex. SE-A2)",
                    icon: Icons.face,
                    obscureText: false,
                  ),

                  SizedBox(height: 30),
                  AppBtn(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApprovalScreen(),
                        ),
                        (r) => false,
                      );
                    },
                    child: Text("Continue"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (widget.role == "Student") {
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
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
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
                    hint: "GFM Batch(ex. SE-A2)",
                    icon: Icons.face,
                    obscureText: false,
                  ),

                  SizedBox(height: 30),
                  AppBtn(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApprovalScreen(),
                        ),
                        (r) => false,
                      );
                    },
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
                AppInputField(
                  hint: "GFM (ex. SE-A2)",
                  icon: Icons.face,
                  obscureText: false,
                ),

                SizedBox(height: 30),
                AppBtn(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ApprovalScreen()),
                      (r) => false,
                    );
                  },
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
