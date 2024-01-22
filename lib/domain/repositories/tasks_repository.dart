import 'package:todo_listapp_r5/domain/entities/task_entity.dart';

abstract class TasksRepository {
  Future<List<TaskEntity>> getTasks();
  Future<TaskEntity> createTask(TaskEntity task);
  Future<void> deleteTask(String id);
}
