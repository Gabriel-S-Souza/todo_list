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
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer yXebwp3RfqdJ6AOm67oW-EIVxx1nbI8JpGBEgrYDRM5kbjAZXw',
          },
        )
      );
      return response.data;
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
      return response.data;
    } catch (e) {
      log('put error: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> delete({dynamic body}) async {
    try {
      final response = await dio.delete(
        baseUrl, 
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer yXebwp3RfqdJ6AOm67oW-EIVxx1nbI8JpGBEgrYDRM5kbjAZXw',
          },
        )
      );
      return response.data;
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
  Future<void> create(String data) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int index) {
    // TODO: implement delete
    throw UnimplementedError();
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
  Future<void> update(int index, String data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future createFromList(List<TasksBoardModel> list) {
    // TODO: implement createFromList
    throw UnimplementedError();
  }

  @override
  Future<void> createTask(String data, Map<int, String> tasks, String id) async {
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
  Future<void> deleteTask(int innerIndex, Map<int, String> tasks, String id) async {
    //TODO: ajustar

    // Map<String, String> tasksStringKeys = {};
    // for (var i = 0; i < tasks.length; i++) {
    //   if (innerIndex == tasks.keys.toList()[i]) {
    //     tasks.remove(tasks.keys.toList()[i]);
    //     continue;
    //   }
    //   if (tasks.keys.toList()[i] > innerIndex) {
    //     tasks[i - 1] = tasks[tasks.keys.toList()[i]]!;
    //   }
    //   tasksStringKeys[i.toString()] = tasks[i]!;
    // }

    // return await dioClient.put(
    //   body: {
    //     "_uuid": id,
    //     "tasks": tasksStringKeys,
    //   }
    // );
  }
}