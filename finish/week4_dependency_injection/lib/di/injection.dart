import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:week4_dependency_injection/config/config.dart';
import 'package:week4_dependency_injection/data/api.dart';
import 'package:week4_dependency_injection/ui/cubit/auth_cubit.dart';
import 'package:week4_dependency_injection/utils/token_interceptor.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton(TokenInterceptor(const FlutterSecureStorage()));

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: Config.baseUrl));
    dio.interceptors.add(getIt<TokenInterceptor>());
    dio.interceptors.add(DioLoggingInterceptor(level: Level.body));
    return dio;
  });

  getIt.registerSingleton<Api>(Api(getIt()));
  getIt.registerFactory(() => AuthCubit(getIt()));
}
