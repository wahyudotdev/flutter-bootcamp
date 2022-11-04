import 'dart:io';

import 'package:dio/dio.dart';
import 'package:week3_networking/models/api_response.dart';
import 'package:week3_networking/models/user.dart';

abstract class Api {
  Future<User> login(String email, String password);
}

class ApiImpl implements Api {
  final Dio dio;

  ApiImpl(this.dio);

  @override
  Future<User> login(String email, String password) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });

      final response = await dio.post('/user/login', data: formData);
      if (response.statusCode == HttpStatus.ok) {
        final result = ApiResponse<User?>.fromJson(response.data,
            (json) => User.fromJson(json as Map<String, dynamic>));
        return result.data!;
      }
      throw Exception('Error code ${response.statusCode.toString()}');
    } catch (e) {
      rethrow;
    }
  }
}
