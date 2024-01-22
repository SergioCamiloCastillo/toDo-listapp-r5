import 'package:todo_listapp_r5/domain/domain.dart';

class TasksRepositoryImpl extends TasksRepository {
  final TasksDataSource tasksDataSource;

  TasksRepositoryImpl({required this.tasksDataSource});

  @override
  Future<TaskEntity> createTask(TaskEntity task) {
    return tasksDataSource.createTask(task);
  }

  @override
  Future<void> deleteTask(String id) {
    return tasksDataSource.deleteTask(id);
  }

  @override
  Future<List<TaskEntity>> getTasks() {
    return tasksDataSource.getTasks();
  }
}
