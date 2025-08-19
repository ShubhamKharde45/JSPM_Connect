import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'profilePicUrl': student.photoUrl,
        'name': student.name,
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
      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'profilePicUrl': faculty.photoUrl,
        'name': faculty.name,
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
      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'profilePicUrl': member.photoUrl,
        'name': member.name,
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

  Future<String> getUserProfilePicByUID(String uid) async {
    try {
      final snap = await firestore.collection('Users').doc(uid).get();
      final docSnap = snap.data();

      final String role = docSnap!['profilePicUrl'];
      return role;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getUserNameByUID(String uid) async {
    try {
      final snap = await firestore.collection('Users').doc(uid).get();
      final docSnap = snap.data();

      final String name = docSnap!['name'];
      return name;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> likeNotice(String uid) async {
    try {
      final snap = await firestore.collection('Notices').doc(uid).update({
        'likeUsers' : [FirebaseAuth.instance.currentUser!.uid]
      });
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> disLikeNotice(String uid) async {
    try {
      final snap = await firestore.collection('Notices').doc(uid).update({
        'disLikeUsers' : [FirebaseAuth.instance.currentUser!.uid]
      });
    } catch (e) {
      rethrow;
    }
  }

  // NOTICE
}
