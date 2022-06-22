import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_list/app/models/task_board_model.dart';

import '../contracts/boards_data_manager.dart';

class DioClient {
  final Dio dio = Dio();
  final baseUrl = 'https://crudapi.co.uk/api/v1/taskboard';

  Future<List<TasksBoardModel>?> get() async {
    try {
      final response = await dio.get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer yXebwp3RfqdJ6AOm67oW-EIVxx1nbI8JpGBEgrYDRM5kbjAZXw',
          },
        )
      );
      return (response.data["items"] as List).map((e) =>
           TasksBoardModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      log('get error: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> post({dynamic body}) async {
    try {
      final response = await dio.post(
        baseUrl, 
        data: [body],
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer yXebwp3RfqdJ6AOm67oW-EIVxx1nbI8JpGBEgrYDRM5kbjAZXw',
          },
        )
      );
      return (response.data["items"] as List).map((e) =>
           TasksBoardModel.fromJson(e as Map<String, dynamic>)).toList()[0];
    } catch (e) {
      log('post error: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> put({required Map<String, dynamic> body}) async {
    try {
      final response = await dio.put(
        baseUrl, 
        data: [body],
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer yXebwp3RfqdJ6AOm67oW-EIVxx1nbI8JpGBEgrYDRM5kbjAZXw',
          },
        )
      );
      return (response.data["items"] as List).map((e) =>
           TasksBoardModel.fromJson(e as Map<String, dynamic>)).toList()[0];
    } catch (e) {
      log('put error: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> delete({required String id}) async {
    try {
      final response = await dio.delete(
        baseUrl,
        data: [{
          "_uuid": id,
        }], 
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer yXebwp3RfqdJ6AOm67oW-EIVxx1nbI8JpGBEgrYDRM5kbjAZXw',
          },
        )
      );
      return (response.data["items"] as List).map((e) =>
           TasksBoardModel.fromJson(e as Map<String, dynamic>)).toList()[0];
    } catch (e) {
      log('delete error: ${e.toString()}');
      return null;
    }
  }
}

class HttpTaskBoardManager implements IBoardsDataManager {
  DioClient dioClient = DioClient();

  @override
  Future<List<TasksBoardModel>?> read() async {
    return await dioClient.get();
  }
  
  @override
  Future create(String title, int position) async {
    return await dioClient.post(body: {
      "title": title,
      "tasks": {},
      "position": position
    });
  }

  @override
  Future delete(String id) async {
    return await dioClient.delete(id: id);
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<void> move(int newIndex, int oldIndex) {
    // TODO: implement move
    throw UnimplementedError();
  } 

  @override
  Future<void> update(TasksBoardModel board) async {
    return await dioClient.put(body: {
      "_uuid": board.id,
      "title": board.title,
      "tasks": board.tasks,
      "position": board.position
    });    
  }

  @override
  Future createFromList(List<TasksBoardModel> list) async {
    // final List<TasksBoardModel> responseList = [];

    // for (int i = 0; i < list.length; i++) {

    //   final Map<String, String> tasksStringKeys = {};

    //   for (var j = 0; j < list[i].tasks.length; j++) {
    //     tasksStringKeys[j.toString()] = list[i].tasks[j]!;
    //   }

    //   final TasksBoardModel responseBoard = await dioClient.post(
    //     body: {
    //     "tasks": tasksStringKeys,
    //     "title": list[i].title,
    //     "position": list[i].position
    //   }
    //   );
    //   responseList.add(responseBoard);
    // }

    // return responseList;
  }

  @override
  Future createTask(String data, Map<int, String> tasks, String id) async {
    final Map<String, String> tasksStringKeys = {};
    final int index = tasks.length;
    tasks[index] = data;

    for (var i = 0; i < tasks.length; i++) {
      tasksStringKeys[i.toString()] = tasks[i]!;
    }

    return await dioClient.put(
      body: {
        "_uuid": id,
        "tasks": tasksStringKeys,
      }
    );
  }

  @override
  Future<dynamic> updateTask(Map<int, String> tasks, String id) async {
    Map<String, String> tasksStringKeys = {};
    
    for (var i = 0; i < tasks.length; i++) {
      tasksStringKeys[i.toString()] = tasks[i]!;
    }

    return await dioClient.put(
      body: {
        "_uuid": id,
        "tasks": tasksStringKeys,
      }
    );
  }

  @override
  Future moveTask(Map<int, String> oldTasks, String oldId, Map<int, String> newTasks, String newId) async {
    Map<String, String> oldTasksStringKeys = {};
    Map<String, String> newTasksStringKeys = {};
    dynamic responseNew;
    dynamic responseOld;

    for (var i = 0; i < newTasks.length; i++) {
      newTasksStringKeys[i.toString()] = newTasks[i]!;
    }
    for (var i = 0; i < oldTasks.length; i++) {
      oldTasksStringKeys[i.toString()] = oldTasks[i]!;
    }

    responseNew = await dioClient.put(
      body: {
        "_uuid": newId,
        "tasks": newTasksStringKeys,
      }
    );

    responseOld = await dioClient.put(
      body: {
        "_uuid": oldId,
        "tasks": oldTasksStringKeys,
      }
    );

    return [responseNew, responseOld];
  }
  
  @override
  Future<void> deleteTask(int innerIndex, Map<int, String> tasks, String id) async {}
}