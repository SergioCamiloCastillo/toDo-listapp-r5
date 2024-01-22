class TaskEntity {
  String id;
  String title;
  String description;
  String date;
  bool isCompleted;
  bool isTranslated = false;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
    required this.isTranslated,
  });

  TaskEntity copyWith({String? id, String? description, bool? isCompleted, bool? isTranslated, String? title, String? date}) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isTranslated: isTranslated ?? this.isTranslated,
    );
  }
}
