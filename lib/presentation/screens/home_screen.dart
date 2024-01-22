import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksState = ref.watch(tasksProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                  const Text('Hoy es: Jueves 18 de enero')
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
                  builder: (context) =>  const CustomModalBottomSheet(),
                ),
                child: Text(
                  '+ Agregar tarea',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          tasksState.tasks.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: tasksState.tasks.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final task = tasksState.tasks[index];
                      return CustomCardTasks(
                        id: task.id,
                        title: task.title,
                        description: task.description,
                        date: task.date,
                        isDone: task.isCompleted,
                      );
                    },
                  ),
                )
              : const Text('No hay tareas')
        ],
      ),
    );
  }
}
