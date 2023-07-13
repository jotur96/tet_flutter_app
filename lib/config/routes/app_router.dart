import 'package:go_router/go_router.dart';
import 'package:tet_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:tet_flutter_app/features/home/data/models/user_model.dart';
import 'package:tet_flutter_app/features/home/presentation/screens/home.dart';
import 'package:tet_flutter_app/features/home/presentation/screens/user_detail.dart';




final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/userDetail',
      builder: (context, state){
        final user = state.extra as UserModel;
        return UserDetail(user: user);
      })

  ]
); 