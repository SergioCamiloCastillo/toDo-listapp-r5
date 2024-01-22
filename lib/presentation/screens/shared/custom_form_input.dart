import 'package:flutter/material.dart';

class CustomFormInput extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;
  final TextEditingController? controller; // Añade el controlador aquí

  const CustomFormInput({
    Key? key,
    required this.label,
    required this.hintText,
    required this.maxLines,
    this.controller, // Incluye el controlador en el constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: TextField(
        controller: controller, // Pasa el controlador al TextField
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}