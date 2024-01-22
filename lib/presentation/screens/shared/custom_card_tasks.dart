import 'package:flutter/material.dart';

class CustomCardTasks extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final bool isDone;
  const CustomCardTasks(
      {Key? key,
      required this.title,
      required this.description,
      required this.date,
      required this.isDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: true,
                            onChanged: (value) {},
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
                          Divider(thickness: 1.5, color: Colors.grey.shade200),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Text('Fecha: '),
                              const SizedBox(width: 10),
                              Text(
                                date,
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
    );
  }
}
