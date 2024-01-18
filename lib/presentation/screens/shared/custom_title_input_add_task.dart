import 'package:flutter/material.dart';
import 'package:todo_listapp_r5/presentation/screens/shared/custom_form_input.dart';

class CustomTitleInputAddTask extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;

  const CustomTitleInputAddTask({
    Key? key,
    required this.label,
    required this.hintText,
    required this.maxLines,
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
        ),
      ],
    );
  }
}
