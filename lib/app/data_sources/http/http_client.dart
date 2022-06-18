import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();
  final baseUrl = 'https://crudapi.co.uk/api/v1/taskboard';

  Future<dynamic> get() async {
    try {
      final response = await dio.get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer yXebwp3RfqdJ6AOm67oW-EIVxx1nbI8JpGBEgrYDRM5kbjAZXw',
          },
        )
      );
      return response.data;
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
}