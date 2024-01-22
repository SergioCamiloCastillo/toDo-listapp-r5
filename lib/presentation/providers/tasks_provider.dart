import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_listapp_r5/domain/domain.dart';
import 'package:todo_listapp_r5/presentation/providers/tasks_repository_provider.dart';

final tasksProvider = StateNotifierProvider<TasksNotifier, TasksState>((ref) {
  final tasksRepository = ref.watch(tasksRespositoryProvider);
  return TasksNotifier(tasksRepository: tasksRepository);
});

class TasksNotifier extends StateNotifier<TasksState> {
  final TasksRepository tasksRepository;
  TasksNotifier({required this.tasksRepository}) : super(TasksState()) {
    getTasks();
  }

  Future<void> getTasks() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    final tasks = await tasksRepository.getTasks();
    if (tasks.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: false, tasks: [...state.tasks, ...tasks]);
  }
}

class TasksState {
  final bool isLoading;
  final List<TaskEntity> tasks;

  TasksState({this.isLoading = false, this.tasks = const []});

  TasksState copyWith({bool? isLoading, List<TaskEntity>? tasks}) {
    return TasksState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
    );
  }
}
