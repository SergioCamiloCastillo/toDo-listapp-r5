class TaskEntity {
  String id;
  String title;
  String description;
  String date;
  bool isCompleted;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
  });
}
