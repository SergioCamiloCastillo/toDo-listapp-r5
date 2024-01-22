import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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

  Future<void> addTask(TaskEntity task) async {
    state = state.copyWith(isLoading: true);
    final taskAdded = await tasksRepository.createTask(task);
    state =
        state.copyWith(isLoading: false, tasks: [...state.tasks, taskAdded]);

    // Ordenar las tareas por la propiedad date de manera descendente después de agregar una nueva tarea
    state.tasks = sortTasksByDate(state.tasks);
  }

  List<TaskEntity> sortTasksByDate(List<TaskEntity> tasks) {
    tasks.sort((a, b) {
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      final DateTime dateA = dateFormat.parse(a.date);
      final DateTime dateB = dateFormat.parse(b.date);
      return dateB.compareTo(dateA);
    });

    return tasks;
  }

  Future<void> deleteTask(String id) async {
    state = state.copyWith(isLoading: true);
    await tasksRepository.deleteTask(id);

    // Actualizar el estado excluyendo la tarea eliminada y ordenar las tareas por fecha
    state.tasks =
        sortTasksByDate(state.tasks.where((task) => task.id != id).toList());

    state = state.copyWith(isLoading: false);
  }

  Future<void> updateStateTask(String id, bool isCompleted) async {
    state = state.copyWith(isLoading: true);
    await tasksRepository.updateStateTask(id, isCompleted);

    // Encontrar la tarea con el ID especificado y actualizar su valor isCompleted
    final updatedTasks = state.tasks.map((task) {
      return task.id == id ? task.copyWith(isCompleted: isCompleted) : task;
    }).toList();

    // Actualizar el estado y ordenar las tareas por fecha
    state.tasks = sortTasksByDate(updatedTasks);
    state = state.copyWith(isLoading: false);
  }

  Future<void> updateStateTranslate(String id, bool isTranslated) async {
    state = state.copyWith(isLoading: true);

    // Find the task with the specified id and update its isTranslated value
    final updatedTasks = state.tasks.map((task) {
      return task.id == id ? task.copyWith(isTranslated: isTranslated) : task;
    }).toList();

    state = state.copyWith(
      isLoading: false,
      tasks: updatedTasks,
    );
  }
}

class TasksState {
  final bool isLoading;
  List<TaskEntity> tasks;

  TasksState({this.isLoading = false, this.tasks = const []});

  TasksState copyWith({bool? isLoading, List<TaskEntity>? tasks}) {
    return TasksState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
    );
  }
}
