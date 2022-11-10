import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:week4_dependency_injection/config/config.dart';
import 'package:week4_dependency_injection/data/api.dart';
import 'package:week4_dependency_injection/ui/cubit/auth_cubit.dart';
import 'package:week4_dependency_injection/ui/router.dart';
import 'package:week4_dependency_injection/utils/token_interceptor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = Platform.isAndroid ? 'android' : 'ios';
    final dio = Dio(
        BaseOptions(baseUrl: Config.baseUrl, headers: {'platform': platform}));
    dio.interceptors.add(TokenInterceptor(const FlutterSecureStorage()));
    dio.interceptors.add(DioLoggingInterceptor(level: Level.body));
    return BlocProvider(
      create: (context) => AuthCubit(Api(dio)),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
