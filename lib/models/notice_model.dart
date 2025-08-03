class Notice {
  final String id;
  final String title;
  final String description;
  final String type;
  final int dateTime;
  final String createdBy;
  final List<String> visibleTo; // ['Student', 'Faculty'] etc.
  final String? attachmentUrl;

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.dateTime,
    required this.createdBy,
    required this.visibleTo,
    this.attachmentUrl,
  });

  factory Notice.fromMap(Map<String, dynamic> map, String docId) {
    return Notice(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
      dateTime: (map['dateTime']),
      createdBy: map['createdBy'] ?? '',
      visibleTo: List<String>.from(map['visibleTo'] ?? []),
      attachmentUrl: map['attachmentUrl'],
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
    };
  }
}
