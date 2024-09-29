class Task {
  static const String collectionName = 'tasks';
  String id;

  String title;

  String description;

  DateTime dateTime;

  bool isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  Task.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
          isDone: json['isDone'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
