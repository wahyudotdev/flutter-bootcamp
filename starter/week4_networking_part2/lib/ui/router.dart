import 'package:go_router/go_router.dart';
import 'package:week3_networking/ui/login_screen.dart';
import 'package:week3_networking/ui/menu_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/menu',
    builder: (context, state) => const MenuScreen(),
  )
]);
