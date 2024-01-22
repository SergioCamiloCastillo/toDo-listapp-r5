import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_listapp_r5/domain/domain.dart';
import 'package:todo_listapp_r5/infrastructure/mappers/task_mapper.dart';

class TasksDatasourceImpl extends TasksDataSource {
  final todoCollection =
      FirebaseFirestore.instance.collection('todoAppFlutterR5');

  @override
  Future<TaskEntity> createTask(TaskEntity task) async {
    try {
      // Convertir TaskEntity a un mapa usando entityToJson
      Map<String, dynamic> taskMap = TaskMapper.entityToJson(task);

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

      // Mapear documentos a objetos TaskEntity usando jsonToEntity
      List<TaskEntity> tasks = querySnapshot.docs
          .map<TaskEntity>((doc) =>
              TaskMapper.jsonToEntity(doc.data() as Map<String, dynamic>))
          .toList();

      tasks.sort((a, b) => b.date.compareTo(a.date));

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
      // Realizar una consulta para obtener documentos con title_task igual a 'pendejo'
      QuerySnapshot querySnapshot =
          await todoCollection.where('id', isEqualTo: id).get();

      // Iterar sobre los documentos y eliminarlos
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }
    } catch (e) {
      // Manejar errores, por ejemplo, imprimir el error
      print("Error deleting tasks: $e");
      rethrow; // Relanzar la excepción para que pueda ser manejada en la capa superior
    }
  }

  @override
  Future<void> updateStateTask(String id, bool isCompleted) async {
    try {
      // Realizar una consulta para obtener documentos con title_task igual a 'pendejo'
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await todoCollection.where('id', isEqualTo: id).get();

      // Iterar sobre los documentos y actualizar 'isCompleted'
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        await documentSnapshot.reference.update({'is_completed': isCompleted});
      }
    } catch (e) {
      print("Error update tasks: $e");
      rethrow; //
    }
  }
}
