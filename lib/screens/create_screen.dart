import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jspm_connect/models/notice_model.dart';
import 'package:jspm_connect/services/database/database.dart';
import 'package:jspm_connect/utils/app_btn.dart';
import 'package:jspm_connect/utils/app_container.dart';
import 'package:jspm_connect/utils/app_input_field.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController attachmentController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  List<String> noticeTypes = [
    'Exam Schedule',
    'Timetable Change',
    'Assignment Deadline',
    'Result Announcement',
    'Holiday Notice',
    'Fee Payment Deadline',
    'Event Announcement',
    'Placement Notice',
    'Workshop / Seminar',
    'Guest Lecture',
    'Emergency Alert',
    'General Announcement',
  ];

  List<String> categories = ["All", "Student", "Faculty", "Member"];

  String? selectNoticeType;
  String? selectCategoryType;

  void setNotice() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('Notices').doc();
      Notice notice = Notice(
        id: docRef.id,
        title: titleController.text,
        description: descController.text,
        type: selectNoticeType!,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        createdBy: FirebaseAuth.instance.currentUser!.uid,
        visibleTo: [selectCategoryType!],
        profileUrl: await Database().getUserProfilePicByUID(
          FirebaseAuth.instance.currentUser!.uid,
        ),
        creatorName: await Database().getUserNameByUID(
          FirebaseAuth.instance.currentUser!.uid,
        ),
        attachmentUrl: attachmentController.text,
        priority: int.parse(priorityController.text),
      );
      await docRef.set(notice.toMap());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Notice created")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    selectNoticeType = noticeTypes[0];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppContainer(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DropdownMenu(
                initialSelection: noticeTypes[0],
                requestFocusOnTap: true,
                hintText: "Select notice type.",
                width: MediaQuery.of(context).size.width * 0.9,
                dropdownMenuEntries: noticeTypes
                    .map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList(),
                onSelected: (value) => setState(() {
                  selectNoticeType = value!;
                }),

                inputDecorationTheme: const InputDecorationTheme(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                ),
              ),
            ),
            SizedBox(height: 10),
            AppContainer(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DropdownMenu(
                initialSelection: noticeTypes[0],
                requestFocusOnTap: true,
                hintText: "Select peoples.",
                width: MediaQuery.of(context).size.width * 0.9,
                dropdownMenuEntries: categories
                    .map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList(),
                onSelected: (value) => setState(() {
                  selectCategoryType = value;
                }),

                inputDecorationTheme: const InputDecorationTheme(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                ),
              ),
            ),
            SizedBox(height: 10),
            AppContainer(
              width: MediaQuery.of(context).size.width * 0.9,
              child: AppInputField(
                hint: "Enter notice title",
                icon: Icons.pending_actions_outlined,
                obscureText: false,
                controller: titleController,
              ),
            ),

            SizedBox(height: 10),
            AppContainer(
              width: MediaQuery.of(context).size.width * 0.9,
              child: AppInputField(
                hint: "Enter Desc",
                obscureText: false,
                controller: descController,
              ),
            ),

            SizedBox(height: 10),
            AppContainer(
              width: MediaQuery.of(context).size.width * 0.9,
              child: AppInputField(
                hint: "Enter attachment url",
                obscureText: false,
                controller: attachmentController,
              ),
            ),

            SizedBox(height: 10),
            AppContainer(
              width: MediaQuery.of(context).size.width * 0.9,
              child: AppInputField(
                hint: "set priority (1-3)",
                obscureText: false,
                controller: priorityController,
              ),
            ),
            SizedBox(height: 30),
            AppBtn(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              onTap: setNotice,
              child: Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
