import 'package:todo_listapp_r5/domain/domain.dart';

class TaskMapper {
  static jsonToEntiy(Map<String, dynamic> json) => TaskEntity(
      id: json['id'] ?? '',
      title: json['title_task'] ?? '',
      description: json['description'] ?? '',
      date: json['date_task'] ?? '',
      isCompleted: json['is_completed']);
}
