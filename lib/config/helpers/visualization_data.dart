import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';

String convertToFormattedDate(String date) {
  DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

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
      List<int> bytes = utf8.encode(input);

      int hash = Random().nextInt(1000);

      const mixFactor = 31;

      for (int byte in bytes) {
        hash = (hash * mixFactor) ^ byte;
      }

      String hexHash = hash.toRadixString(16);

      return hexHash;
    }

