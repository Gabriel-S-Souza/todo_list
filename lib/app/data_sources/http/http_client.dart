import 'dart:convert';
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

  Future<dynamic> put({dynamic body}) async {
    try {
      final response = await dio.put(
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
  Future<void> createTask(String data, int outerIndex, [int? insertIndex]) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(int innerIndex, int outerIndex) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(String data, int innerIndex, int outerIndex) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Future<void> moveTask(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    // TODO: implement moveTask
    throw UnimplementedError();
  }
}