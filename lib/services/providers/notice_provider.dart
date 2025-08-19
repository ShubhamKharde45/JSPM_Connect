import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/models/notice_model.dart';

final noticeProvider = StreamProvider.family<Notice, String>((ref, noticeId) {
  return FirebaseFirestore.instance
      .collection('notices')
      .doc(noticeId)
      .snapshots()
      .map((doc) => Notice.fromMap(doc.data()!, doc.id));
});
