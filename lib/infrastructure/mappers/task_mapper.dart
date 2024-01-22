import 'package:todo_listapp_r5/domain/domain.dart';

class TaskMapper {
  // Convierte un objeto TaskEntity a un mapa
  static Map<String, dynamic> entityToJson(TaskEntity task) {
    return {
      'id': task.id,
      'title_task': task.title,
      'description': task.description,
      'date_task': task.date,
      'is_completed': task.isCompleted,
    };
  }

  // Convierte un mapa a un objeto TaskEntity
  static TaskEntity jsonToEntity(Map<String, dynamic>? data) {
    if (data == null) {
      return TaskEntity(
        id: '',
        title: '',
        description: '',
        date: '',
        isCompleted: false,
      );
    }

    return TaskEntity(
      id: data['id'] ?? '',
      title: data['title_task'] ?? '',
      description: data['description'] ?? '',
      date: data['date_task'] ?? '',
      isCompleted: data['is_completed'] ?? false,
    );
  }
}
