import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }
  static String nameCollectionFireStore =
      dotenv.env['NAME_COLLECTION_FIRESTORE'] ??
          'No esta configurado el nombre de la colección de firestore';
}
