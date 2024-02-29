import 'dart:convert';

class Task {
  String name;
  DateTime date;
  String tag;
  String taskdescp;
  bool isCompleted;

  Task({
    required this.name,
    required this.date,
    required this.tag,
    required this.taskdescp,
    this.isCompleted = false,
  });

  String toJsonString() {
    Map<String, dynamic> json = {
      'name': name,
      'date': date.toString(),
      'tag': tag,
      'taskdescp': taskdescp,
      'isCompleted': isCompleted,
    };
    return jsonEncode(json);
  }

  factory Task.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Task(
      name: json['name'] ?? '', 
      date: DateTime.parse(json['date'] ?? ''), 
      tag: json['tag'] ?? '', 
      taskdescp: json['taskdescp'] ?? '',
      isCompleted: json['isCompleted'] ?? false, 
    );
  }
}
