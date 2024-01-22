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

  TaskEntity copyWith({String? id, String? description, bool? isCompleted}) {
    return TaskEntity(
      id: id ?? this.id,
      title: title,
      date: date,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
