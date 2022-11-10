import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import '../config/config.dart';
import 'dio_error_wrapper.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  final FlutterSecureStorage _storage;

  static const authTokenKey = 'AUTH_TOKEN';
  static const fcmTokenKey = 'FCM_TOKEN';
  static const expiredMessage = 'expired_token';

  TokenInterceptor(this._storage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final savedToken = await _savedToken;
    if (savedToken == null) {
      final opt = Options(headers: {'Authorization': initialToken});
      final response = await Dio(BaseOptions(baseUrl: Config.baseUrl))
          .get('/user/get-token', options: opt);
      if (response.statusCode == HttpStatus.ok) {
        final body = response.data as Map<String, dynamic>;
        final token = body['token'];
        await _storage.write(key: authTokenKey, value: token);

        final headers = {
          'Authorization': token,
          'platform': Platform.isAndroid ? 'android' : 'ios',
        };
        return handler.next(options.copyWith(
          headers: headers,
        ));
      }
    } else {
      final headers = {
        'Authorization': savedToken,
        'platform': Platform.isAndroid ? 'android' : 'ios',
      };
      return handler.next(options.copyWith(headers: headers));
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == HttpStatus.ok &&
        response.realUri.path.contains('/login')) {
      final data = response.data as Map<String, dynamic>;
      final token = data['token'];
      await _storage.write(key: authTokenKey, value: token);
    }
    if (response.statusCode == HttpStatus.ok &&
        response.realUri.path.contains('/logout')) {
      await _storage.deleteAll();
    }
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (shouldRetry(err)) {
      try {
        final headers = {'Authorization': await _savedToken};
        final response = await Dio(
          BaseOptions(
            baseUrl: Config.baseUrl,
            headers: headers,
          ),
        ).get('/user/refresh-token');
        if (response.statusCode == HttpStatus.ok) {
          final body = response.data as Map<String, dynamic>;
          final token = body['token'];
          await _storage.write(key: authTokenKey, value: token);
          await retryRequest(err, handler);
        } else {
          return handler.reject(DioErrorWrapper(
              requestOptions: err.requestOptions, dioError: err));
        }
      } catch (e) {
        return handler.reject(
            DioErrorWrapper(requestOptions: err.requestOptions, dioError: err));
      }
    } else {
      return handler.reject(
          DioErrorWrapper(requestOptions: err.requestOptions, dioError: err));
    }
  }

  String get initialToken {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final apiKey = base64Encode('$date|${Config.apiSecret}'.codeUnits);
    return apiKey;
  }

  Future<String?> get _savedToken async {
    return await _storage.read(key: authTokenKey);
  }

  bool shouldRetry(DioError error) {
    return error.type == DioErrorType.response &&
        error.response?.data?['error'] == expiredMessage;
  }

  Future retryRequest(DioError err, ErrorInterceptorHandler handler) async {
    final headers = {
      'Authorization': await _savedToken,
      'platform': Platform.isAndroid ? 'android' : 'ios',
    };
    final response = await Dio().fetch(err.requestOptions.copyWith(
      headers: headers,
    ));
    if (response.statusCode == HttpStatus.ok) {
      return handler.resolve(response);
    } else {
      return handler.reject(
          DioErrorWrapper(requestOptions: err.requestOptions, dioError: err));
    }
  }
}
