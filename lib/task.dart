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
}
