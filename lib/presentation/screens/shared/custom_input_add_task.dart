import 'package:flutter/material.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom.dart';

class CustomInputAddTask extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;

  const CustomInputAddTask({
    Key? key,
    required this.label,
    required this.hintText,
    required this.maxLines,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomFormInput(
          label: label,
          hintText: hintText,
          maxLines: maxLines,
          controller: controller,
        ),
      ],
    );
  }
}
