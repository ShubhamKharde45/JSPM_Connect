class MemberModel {
  final String uid;
  final String name;
  final String email;
  final String? role;          // e.g., "hod", "guard", "office", "helper"
  final String? department;    // Optional: only for HOD/office staff
  final String? designation;   // e.g., "HOD", "Lab Assistant"
  final String? photoUrl;
  final bool isApproved;       // NEW: Approval status

  MemberModel({
    required this.uid,
    required this.name,
    required this.email,
    this.role,
    this.department,
    this.designation,
    this.photoUrl,
    this.isApproved = false, // default to false
  });

  factory MemberModel.fromMap(Map<String, dynamic> data, String docId) {
    return MemberModel(
      uid: docId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      department: data['department'],
      designation: data['designation'],
      photoUrl: data['photoUrl'],
      isApproved: data['isApproved'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'department': department,
      'designation': designation,
      'photoUrl': photoUrl,
      'isApproved': isApproved,
    };
  }
}
