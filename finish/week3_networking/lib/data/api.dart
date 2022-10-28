import 'dart:io';

import 'package:dio/dio.dart';
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
        return User.fromJson(response.data['data']);
      }
      throw Exception('Error code ${response.statusCode.toString()}');
    } catch (e) {
      rethrow;
    }
  }
}
