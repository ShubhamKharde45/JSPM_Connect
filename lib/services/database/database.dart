import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jspm_connect/models/faculty_model.dart';
import 'package:jspm_connect/models/member_model.dart';
import 'package:jspm_connect/models/student_model.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> initializeStudent(StudentModel student) async {
    try {
      await firestore
          .collection('Students')
          .doc(auth.currentUser!.uid)
          .set(student.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> initializeFaculty(FacultyModel faculty) async {
    try {
      await firestore
          .collection('Faculty')
          .doc(auth.currentUser!.uid)
          .set(faculty.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> initializeMembers(MemberModel member) async {
    try {
      await firestore
          .collection('Member')
          .doc(auth.currentUser!.uid)
          .set(member.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
