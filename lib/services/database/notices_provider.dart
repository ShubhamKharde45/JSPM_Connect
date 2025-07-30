import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/models/notice_model.dart';
import 'package:jspm_connect/services/auth/user_role_provider.dart';

final noticesProvider = StreamProvider<List<Notice>>((ref) {
  final role = ref.watch(userRoleProvider);

  if (role == null) return const Stream.empty();

  final query = FirebaseFirestore.instance
      .collection('Notices')
      .where('visibleTo', arrayContains: "Student")
      .snapshots();

  return query.map((snapshot) {
    return snapshot.docs.map((doc) {
      return Notice.fromMap(doc.data(), doc.id);
    }).toList();
  });
});
