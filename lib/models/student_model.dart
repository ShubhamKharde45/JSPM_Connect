class StudentModel {
  final String uid;
  final String name;
  final String email;
  final String department;     // e.g., "CSE", "ENTC"
  final String year;           // e.g., "FE", "SE", "TE", "BE"
  final String role;           // Should be "student"
  final String? photoUrl;      // Optional: profile image
  final String? gfm;           // UID of assigned GFM
  final bool isApproved;       // NEW: approval status

  StudentModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.department,
    required this.year,
    required this.role,
    this.photoUrl,
    this.gfm,
    this.isApproved = false, // default to false
  });

  // Convert Firestore document to StudentModel
  factory StudentModel.fromMap(Map<String, dynamic> data, String docId) {
    return StudentModel(
      uid: docId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      department: data['department'] ?? '',
      year: data['year'] ?? '',
      role: data['role'] ?? 'student',
      photoUrl: data['photoUrl'],
      gfm: data['gfm'],
      isApproved: data['isApproved'] ?? false,
    );
  }

  // Convert StudentModel to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'department': department,
      'year': year,
      'role': role,
      'photoUrl': photoUrl,
      'gfm': gfm,
      'isApproved': isApproved,
    };
  }
}
