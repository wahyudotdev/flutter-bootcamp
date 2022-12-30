import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:week1_basic_layouting/detail_screen.dart';
import 'package:week1_basic_layouting/home_screen.dart';
import 'package:week1_basic_layouting/profile.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is Profile) {
          return DetailScreen(data: extra);
        }
        return _errorRoutes();
      },
    )
  ],
);

Widget _errorRoutes() {
  return const Scaffold(
    body: Center(
      child: Text('Route Error'),
    ),
  );
}
