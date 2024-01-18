import 'package:flutter/material.dart';
import 'package:todo_listapp_r5/presentation/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(title: const _HeaderTileAppBar()),
        body: const _BodyCustom());
  }
}

class _HeaderTileAppBar extends StatelessWidget {
  const _HeaderTileAppBar({
    super.key,
  });

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

class _BodyCustom extends StatelessWidget {
  const _BodyCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
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
                    'Tareas de hoy',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text('Jueves 18 de enero')
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD5E8FA),
                  foregroundColor: Colors.blue.shade800,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Ajusta el radio según tus preferencias
                  ),
                ),
                onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const CustomModalBottomSheet()),
                child: Text(
                  '+ Agregar tarea',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
