import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRoleProvider = StateProvider<String>((ref) => "");

Future<void> initializeUserRole(WidgetRef ref) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final doc = await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .get();

  if (doc.exists) {
    final role = doc.data()?['role'] ?? "";
    ref.read(userRoleProvider.notifier).state = role;
  }
}
