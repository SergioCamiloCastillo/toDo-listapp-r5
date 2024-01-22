import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:todo_listapp_r5/domain/domain.dart';
import 'package:todo_listapp_r5/shared/infrastructure/inputs/inputs.dart';

final taskFormProvider = StateNotifierProvider.autoDispose
    .family<TaskFormNotifier, TaskFormState, TaskEntity>((ref, task) {
  return TaskFormNotifier(task: task);
});

class TaskFormNotifier extends StateNotifier<TaskFormState> {
  final void Function(Map<String, dynamic> taskLike)? onSubmitCallback;
  TaskFormNotifier({this.onSubmitCallback, required TaskEntity task})
      : super(TaskFormState(
            id: task.id,
            title: Title.dirty(task.title),
            description: Description.dirty(task.description),
            isCompleted: task.isCompleted,
            date: Date.dirty(task.date)));

  void onTitleChanged(String value) {
    state = state.copyWith(
        title: Title.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(value),
          Description.dirty(state.description.value),
          Date.dirty(state.date.value)
        ]));
  }

  void onDescriptionChanged(String value) {
    state = state.copyWith(
        description: Description.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Description.dirty(value),
          Date.dirty(state.date.value)
        ]));
  }

  void onDateChanged(String value) {
    state = state.copyWith(
        date: Date.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Description.dirty(state.description.value),
          Date.dirty(value)
        ]));
  }

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if (!state.isFormValid) return false;
    final taskLike = {
      'id': state.id,
      'title': state.title.value,
      'description': state.description.value,
      'isCompleted': state.isCompleted,
      'date': state.date.value,
    };
    return true;
  }

  void _touchedEverything() {
    state = state.copyWith(
        isFormValid: Formz.validate([
      Title.dirty(state.title.value),
      Description.dirty(state.description.value),
      Date.dirty(state.date.value)
    ]));
  }
}

class TaskFormState {
  final String? id;
  final Title title;
  final Description description;
  final bool? isCompleted;
  final Date date;
  final bool isFormValid;

  TaskFormState({
    this.id,
    this.title = const Title.dirty(''),
    this.description = const Description.dirty(''),
    this.isCompleted = false,
    this.date = const Date.dirty(''),
    this.isFormValid = false,
  });

  TaskFormState copyWith({
    String? id,
    Title? title,
    Description? description,
    bool? isCompleted,
    Date? date,
    bool? isFormValid,
  }) {
    return TaskFormState(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
