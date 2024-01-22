import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_listapp_r5/domain/domain.dart';
import 'package:todo_listapp_r5/infrastructure/mappers/task_mapper.dart';

class TasksDatasourceImpl extends TasksDataSource {
  final todoCollection =
      FirebaseFirestore.instance.collection('todoAppFlutterR5');

  @override
  Future<TaskEntity> createTask(TaskEntity task) async {
    try {
      // Convertir TaskEntity a un mapa
      Map<String, dynamic> taskMap =
          TaskMapper.jsonToEntiy(task as Map<String, dynamic>);

      // Añadir un nuevo documento a la colección
      await todoCollection.add(taskMap);

      // Devolver el objeto TaskEntity creado
      return task;
    } catch (e) {
      // Manejar errores, por ejemplo, imprimir el error
      print("Error creating task: $e");
      rethrow; // Relanzar la excepción para que pueda ser manejada en la capa superior
    }
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    try {
      // Obtener documentos de la colección
      QuerySnapshot querySnapshot = await todoCollection.get();

      // Mapear documentos a objetos TaskEntity
      List<TaskEntity> tasks = querySnapshot.docs
          .map<TaskEntity>((doc) =>
              TaskMapper.jsonToEntiy(doc.data() as Map<String, dynamic>))
          .toList();

      return tasks;
    } catch (e) {
      // Manejar errores, por ejemplo, imprimir el error
      print("Error getting tasks: $e");
      return []; // Devolver una lista vacía en caso de error
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      // Eliminar el documento con el ID proporcionado de la colección
      await todoCollection.doc(id).delete();
    } catch (e) {
      // Manejar errores, por ejemplo, imprimir el error
      print("Error deleting task: $e");
      rethrow; // Relanzar la excepción para que pueda ser manejada en la capa superior
    }
  }
}
