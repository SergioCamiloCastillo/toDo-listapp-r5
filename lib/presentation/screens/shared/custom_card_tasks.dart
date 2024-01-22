import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_listapp_r5/presentation/providers/providers.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom.dart';

class CustomCardTasks extends ConsumerWidget {
  final String id;
  final String title;
  final String description;
  final String date;
  final bool isDone;
  const CustomCardTasks(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isDone})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String convertToFormattedDate(String date) {
      // Parse the input string to a DateTime object using a custom date format
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

      // Format the DateTime object to the desired format
      String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

      return formattedDate;
    }

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
                            title: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              description,
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
                                      const Text('Fecha: '),
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
            Text('Traducir tarea',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.blue.shade500, fontWeight: FontWeight.bold))
          ],
        ),
      ],
    );
  }
}
