import 'package:go_router/go_router.dart';
import 'package:week2_state_manager/ui/login_screen.dart';
import 'package:week2_state_manager/ui/menu_screen.dart';

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
