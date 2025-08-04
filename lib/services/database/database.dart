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

      await firestore.collection('Users').doc(auth.currentUser!.uid).set({
        'role': 'Student',
        'isVarified': false,
        'isFormField': false,
      });
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
      await firestore.collection('Users').doc(auth.currentUser!.uid).set({
        'role': 'Faculty',
        'isVarified': false,
        'isFormField': false,
      });
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
      await firestore.collection('Users').doc(auth.currentUser!.uid).set({
        'role': 'Member',
        'isVarified': false,
        'isFormField': false,
      });
    } catch (e) {
      rethrow;
    }
  }
 
  Future<void> updateFormFillStatus(bool isFormField) async {
    try {
      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'isFormField': isFormField,
      });
    } catch (e) {
      rethrow;
    }
  }

  // NOTICE
}
