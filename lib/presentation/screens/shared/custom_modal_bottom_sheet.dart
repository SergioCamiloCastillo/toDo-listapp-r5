import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_listapp_r5/presentation/providers/providers.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom.dart';

class CustomModalBottomSheet extends ConsumerWidget {
  const CustomModalBottomSheet({super.key});

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            const CustomTitleInputAddTask(
              label: 'Titulo de tarea',
              hintText: 'Añade un titulo',
              maxLines: 1,
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomTitleInputAddTask(
              label: 'Descripción de tarea',
              hintText: 'Añade la descripción',
              maxLines: 1,
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomDateInput(),
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
                    onPressed: () {
                      final tasknotifier = ref.read(tasksProvider.notifier);
                      // Implementa la lógica de guardar aquí
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
}
