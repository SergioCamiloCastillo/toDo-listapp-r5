import 'package:flutter/material.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom_date_input.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom_title_input_add_task.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom_form_input.dart';

class CustomModalBottomSheet extends StatelessWidget {
  const CustomModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
                        borderRadius: BorderRadius.circular(
                            8.0), // Ajusta el radio según tus preferencias
                      ),
                      side: BorderSide(color: Colors.blue.shade800)),
                  child: const Text('Cancelar'),
                  onPressed: () {},
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Ajusta el radio según tus preferencias
                      ),
                      side: BorderSide(color: Colors.blue.shade800)),
                  child: const Text('Guardar'),
                  onPressed: () {},
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
