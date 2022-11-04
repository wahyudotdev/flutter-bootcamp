import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week3_networking/data/api.dart';
import 'package:week3_networking/ui/cubit/auth_cubit.dart';
import 'package:week3_networking/ui/router.dart';
import 'package:week3_networking/utils/token_interceptor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = Platform.isAndroid ? 'android' : 'ios';
    final dio = Dio(BaseOptions(
        baseUrl: 'https://go-flutter-bootcamp-production.up.railway.app/api',
        headers: {'platform': platform}));
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(DioLoggingInterceptor(level: Level.body));
    return BlocProvider(
      create: (context) => AuthCubit(ApiImpl(dio)),
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
