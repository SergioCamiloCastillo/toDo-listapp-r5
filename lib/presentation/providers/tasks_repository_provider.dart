import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_listapp_r5/domain/domain.dart';
import 'package:todo_listapp_r5/infrastructure/infrastructure.dart';

final tasksRespositoryProvider = Provider<TasksRepository>((ref) {
  return TasksRepositoryImpl(tasksDataSource: TasksDatasourceImpl());
});
