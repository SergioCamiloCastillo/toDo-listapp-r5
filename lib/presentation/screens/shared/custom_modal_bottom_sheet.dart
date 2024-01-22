import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_listapp_r5/config/helpers/visualization_data.dart';
import 'package:todo_listapp_r5/domain/domain.dart';
import 'package:todo_listapp_r5/presentation/providers/providers.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom.dart';

class CustomModalBottomSheet extends ConsumerStatefulWidget {
  const CustomModalBottomSheet({Key? key}) : super(key: key);

  @override
  _CustomModalBottomSheetState createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState
    extends ConsumerState<CustomModalBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;
  bool areFieldsValid = true;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Agregar nueva tarea',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            CustomInputAddTask(
              label: 'Titulo de tarea',
              hintText: 'Añade un titulo',
              maxLines: 1,
              controller: titleController,
            ),
            if (!areFieldsValid && titleController.text.isEmpty)
              const Text(
                'El título es obligatorio',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInputAddTask(
              label: 'Descripción de tarea',
              hintText: 'Añade la descripción',
              maxLines: 1,
              controller: descriptionController,
            ),
            if (!areFieldsValid && descriptionController.text.isEmpty)
              const Text(
                'La descripción es obligatoria',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomDateInput(
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: BorderSide(color: Colors.blue.shade800),
                    ),
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: BorderSide(color: Colors.blue.shade800),
                    ),
                    child: const Text('Guardar'),
                    onPressed: () async {
                      if (titleController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        setState(() {
                          areFieldsValid = false;
                        });
                        return;
                      }
                      final taskNotifier = ref.read(tasksProvider.notifier);
                      final formattedDate = DateFormat('dd/MM/yyyy')
                          .format(selectedDate ?? DateTime.now());
                      DateTime now = DateTime.now();
                      setState(() {
                        areFieldsValid = true;
                      });
                      // Convierte la fecha y hora a una cadena formateada
                      String formattedDateTime =
                          "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";

                      // Calcula el hash utilizando una función hash básica
                      String hashId = generateHash(formattedDateTime);
                      final task = TaskEntity(
                        id: hashId,
                        title: titleController.text,
                        description: descriptionController.text,
                        date: formattedDate,
                        isCompleted: false,
                        isTranslated: false,
                        // otros campos
                      );
                      await taskNotifier.addTask(task);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
