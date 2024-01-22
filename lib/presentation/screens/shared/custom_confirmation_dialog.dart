import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomConfirmationDialog({super.key, 
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmación'),
      content: const Text('¿Estás seguro de que quieres realizar esta acción?'),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: const Text('Confirmar'),
        ),
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}