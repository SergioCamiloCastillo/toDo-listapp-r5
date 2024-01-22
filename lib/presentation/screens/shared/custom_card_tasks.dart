import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtext/gtext.dart';
import 'package:todo_listapp_r5/config/helpers/visualization_data.dart';
import 'package:todo_listapp_r5/presentation/providers/providers.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom.dart';

class CustomCardTasks extends ConsumerWidget {
  final String id;
  final String title;
  final String description;
  final String date;
  final bool isDone;
  final bool isTranslated;
  const CustomCardTasks(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isDone,
      required this.isTranslated})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(
                                left: 0), // Ajusta el padding izquierdo
                            title: isTranslated
                                ? GText(
                                    capitalize(title),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    capitalize(title),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                            subtitle: isTranslated
                                ? GText(
                                    capitalize(description),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    toLang: 'en',
                                  )
                                : Text(
                                    capitalize(description),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                            trailing: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                value: isDone,
                                onChanged: (value) {
                                  // Actualizar el estado usando el notifier
                                  ref
                                      .read(tasksProvider.notifier)
                                      .updateStateTask(id, value ?? false);
                                },
                                shape: const CircleBorder(),
                                activeColor: Colors.blue.shade400,
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Column(
                            children: [
                              const SizedBox(height: 2),
                              Divider(
                                  thickness: 1.5, color: Colors.grey.shade200),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      isTranslated
                                          ? const GText('Fecha: ')
                                          : const Text('Fecha: '),
                                      const SizedBox(width: 10),
                                      Text(
                                        convertToFormattedDate(date),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      final taskNotifier =
                                          ref.read(tasksProvider.notifier);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomConfirmationDialog(
                                            onConfirm: () async {
                                              await taskNotifier.deleteTask(id);
                                              Navigator.of(context).pop();
                                            },
                                            onCancel: () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(Icons.translate, color: Colors.blue.shade500),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                // Obtén la tarea actual
                final currentTask = ref
                    .read(tasksProvider)
                    .tasks
                    .firstWhere((task) => task.id == id);

                // Cambiar el estado de "translate" aquí
                ref
                    .read(tasksProvider.notifier)
                    .updateStateTranslate(id, !currentTask.isTranslated);
              },
              child: Text(isTranslated ? 'Dejar de traducir' : 'Traducir tarea',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.blue.shade500,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ],
    );
  }
}
