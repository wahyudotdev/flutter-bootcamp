import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:week4_dependency_injection/config/config.dart';
import 'package:week4_dependency_injection/di/injection.dart';
import 'package:week4_dependency_injection/utils/token_interceptor.dart';

@module
abstract class AppModule {
  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();

  @lazySingleton
  TokenInterceptor get tokenInterceptor => TokenInterceptor(getIt());

  @lazySingleton
  Dio get createDio {
    final dio = Dio(BaseOptions(baseUrl: Config.baseUrl));
    dio.interceptors.add(DioLoggingInterceptor(level: Level.body));
    dio.interceptors.add(getIt<TokenInterceptor>());
    return dio;
  }
}
