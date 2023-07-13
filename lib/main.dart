import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tet_flutter_app/config/routes/app_router.dart';
import 'package:tet_flutter_app/features/auth/data/repositories/auth_repository_impl.dart';

import 'config/theme/app_theme.dart';
import 'features/auth/data/data_sources/auth_local_data.dart';
import 'features/auth/domain/entities/auth_user.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: _);
  runApp(await builder());
}

void main() {
  bootstrap(
    () async {
      AuthLocalData authLocalDataSource = AuthLocalData();
      AuthRepository authRepository = AuthRepositoryImpl(
        authLocalData: authLocalDataSource,
      );

      return App(
        authRepository: authRepository,
        authUser: null
      );
    },
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
    this.authUser,
  });

  final AuthRepository authRepository;
  final AuthUser? authUser;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'ITTI',
        theme: AppTheme().getTheme(),
      ),
    );
  }
}