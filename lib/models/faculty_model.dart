class FacultyModel {
  final String uid;
  final String name;
  final String email;
  final String department;
  final String? role;                 // e.g., "faculty"
  final String? designation;          // e.g., "Assistant Professor"
  final String? photoUrl;             // Optional profile image
  final String? taughtSubject;        // Current subject taught
  final String? gfm;                  // Primary GFM class (e.g., "TE-B")
  final Map<String, bool>? classes;   // All GFM assignments: {'SE-A': true, ...}
  final bool isApproved;              // NEW: Approval status

  FacultyModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.department,
    this.role,
    this.designation,
    this.photoUrl,
    this.taughtSubject,
    this.gfm,
    this.classes,
    this.isApproved = false, // default to false
  });

  factory FacultyModel.fromMap(Map<String, dynamic> data, String docId) {
    return FacultyModel(
      uid: docId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      department: data['department'] ?? '',
      role: data['role'] ?? 'faculty',
      designation: data['designation'],
      photoUrl: data['photoUrl'],
      taughtSubject: data['taughtSubject'],
      gfm: data['gfm'],
      classes: data['classes'] != null
          ? Map<String, bool>.from(data['classes'])
          : null,
      isApproved: data['isApproved'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'department': department,
      'role': role,
      'designation': designation,
      'photoUrl': photoUrl,
      'taughtSubject': taughtSubject,
      'gfm': gfm,
      'classes': classes,
      'isApproved': isApproved,
    };
  }
}
