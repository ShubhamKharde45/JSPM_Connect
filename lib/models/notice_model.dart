class Notice {
  final String id;
  final String title;
  final String description;
  final String type;
  final int dateTime;
  final String createdBy;
  final List<String> visibleTo;
  final String? attachmentUrl;
  final String? profileUrl;
  final String? creatorName;
  final int priority;

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.dateTime,
    required this.createdBy,
    required this.visibleTo,
    this.attachmentUrl,
    this.profileUrl,
    this.creatorName,
    required this.priority,
  });

  factory Notice.fromMap(Map<String, dynamic> map, String docId) {
    return Notice(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
      dateTime: map['dateTime'],
      createdBy: map['createdBy'] ?? '',
      visibleTo: List<String>.from(map['visibleTo'] ?? []),
      attachmentUrl: map['attachmentUrl'],
      profileUrl: map['profileUrl'],
      creatorName: map['creatorName'],
      priority: map['priority'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'dateTime': dateTime,
      'createdBy': createdBy,
      'visibleTo': visibleTo,
      'attachmentUrl': attachmentUrl,
      'profileUrl': profileUrl,
      'creatorName': creatorName,
      'priority': priority,
    };
  }
}
