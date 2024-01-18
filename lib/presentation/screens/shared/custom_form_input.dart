import 'package:flutter/material.dart';

class CustomFormInput extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;
  const CustomFormInput(
      {super.key,
      required this.label,
      required this.hintText,
      required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200),
        child: TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  7.0), // Ajusta el valor según tus necesidades
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  7.0), // Ajusta el valor según tus necesidades
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            hintText: hintText,
          ),
        ));
  }
}
