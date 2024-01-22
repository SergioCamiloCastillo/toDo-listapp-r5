import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_listapp_r5/config/helpers/visualization_data.dart';
import 'package:todo_listapp_r5/domain/domain.dart';

import 'package:todo_listapp_r5/presentation/providers/providers.dart';
import 'package:todo_listapp_r5/presentation/screens/screens.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom_card_tasks.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const _HeaderTileAppBar()),
      body: const _BodyCustom(),
    );
  }
}

class _HeaderTileAppBar extends StatelessWidget {
  const _HeaderTileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: ClipOval(child: Image.asset('assets/images/marty-mcfly.jpeg')),
      ),
      title: Text(
        'Hola, soy',
        style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
      ),
      subtitle: const Text(
        'Marty McFly',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}

class _BodyCustom extends ConsumerStatefulWidget {
  const _BodyCustom({Key? key}) : super(key: key);

  @override
  _BodyCustomState createState() => _BodyCustomState();
}

class _BodyCustomState extends ConsumerState<_BodyCustom> {
  @override
  Widget build(BuildContext context) {
    final tasksState = ref.watch(tasksProvider);

    // Filtrar tareas completadas y no completadas
    final completedTasks =
        tasksState.tasks.where((task) => task.isCompleted).toList();
    final incompleteTasks =
        tasksState.tasks.where((task) => !task.isCompleted).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tareas',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('Hoy es: ${capitalize(getTodayDate())}')
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD5E8FA),
                  foregroundColor: Colors.blue.shade800,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const CustomModalBottomSheet(),
                ),
                child: Text(
                  '+ Agregar tarea',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          tasksState.tasks.isNotEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (incompleteTasks.isNotEmpty)
                          _buildTaskList(context, incompleteTasks,
                              'Tareas Pendientes', true),
                        const SizedBox(height: 20),
                        if (completedTasks.isNotEmpty)
                          _buildTaskList(context, completedTasks,
                              'Tareas Completadas', false),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/box-empty.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('¡Sin tareas!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Por favor, toca el botón para agregar tarea',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 13, color: Color(0xFF59656F)),
                        ),
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, List<TaskEntity> tasks,
      String title, bool arePending) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(arePending ? Icons.pending_actions : Icons.task_alt,
                color: Colors.blue.shade800),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.blue.shade800,
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: tasks.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return CustomCardTasks(
              id: task.id,
              title: task.title,
              description: task.description,
              date: task.date,
              isDone: task.isCompleted,
              isTranslated: task.isTranslated,
            );
          },
        ),
      ],
    );
  }
}
