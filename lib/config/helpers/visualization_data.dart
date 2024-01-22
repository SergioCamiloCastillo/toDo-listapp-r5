import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';

String convertToFormattedDate(String date) {
  // Parse the input string to a DateTime object using a custom date format
  DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

  // Format the DateTime object to the desired format
  String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

  return formattedDate;
}

String capitalize(String text) {
  return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
}
String getTodayDate() {
  DateTime now = DateTime.now();

  String todayDate = DateFormat('EEEE d MMMM', 'es').format(now);

  return todayDate;
}
String generateHash(String input) {
      // Convierte la cadena de entrada a bytes
      List<int> bytes = utf8.encode(input);

      // Inicializa el valor del hash con un número aleatorio
      int hash = Random().nextInt(1000);

      // Factor de mezcla para mejorar la calidad del hash
      const mixFactor = 31;

      // Aplica la función hash sumando y mezclando los valores de los bytes
      for (int byte in bytes) {
        hash = (hash * mixFactor) ^ byte;
      }

      // Convierte el hash a una cadena hexadecimal
      String hexHash = hash.toRadixString(16);

      return hexHash;
    }

