import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    String generateHash(String input) {
      // Convierte la cadena de entrada a bytes
      List<int> bytes = utf8.encode(input);

      // Inicializa el valor del hash con un número aleatorio
      int hash = Random().nextInt(1000);

      // Factor de mezcla para mejorar la calidad del hash
      const mixFactor = 31;

      // Aplica la función hash sumando y mezclando los valores de los bytes
      for (int byte in bytes) {
        hash = (hash * mixFactor) ^ byte;
      }

      // Convierte el hash a una cadena hexadecimal
      String hexHash = hash.toRadixString(16);

      return hexHash;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
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
            const SizedBox(
              height: 15,
            ),
            CustomInputAddTask(
              label: 'Descripción de tarea',
              hintText: 'Añade la descripción',
              maxLines: 1,
              controller: descriptionController,
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
                      final taskNotifier = ref.read(tasksProvider.notifier);
                      final formattedDate = DateFormat('dd/MM/yyyy')
                          .format(selectedDate ?? DateTime.now());
                      DateTime now = DateTime.now();

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
