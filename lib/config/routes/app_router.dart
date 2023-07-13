import 'package:go_router/go_router.dart';
import 'package:tet_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:tet_flutter_app/features/home/presentation/screens/home_screen.dart';




final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/userList',
      builder: (context, state) => const HomeScreen())
  ]
); 