class Task {
  String name;
  DateTime date;
  String tag;
  bool isCompleted;

  Task({
    required this.name,
    required this.date,
    required this.tag,
    this.isCompleted = false,
  });
}
