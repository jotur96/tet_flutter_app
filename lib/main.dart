import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tet_flutter_app/config/routes/app_router.dart';
import 'package:tet_flutter_app/core/services/api/http_client.dart';
import 'package:tet_flutter_app/features/auth/data/repositories/auth_repository_impl.dart';

import 'config/theme/app_theme.dart';
import 'features/auth/data/data_sources/auth_local_data.dart';
import 'features/auth/domain/entities/auth_user.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/home/data/data_sources/remote/user_api_datasources.dart';
import 'features/home/data/repository/user_repository_impl.dart';
import 'features/home/domain/usecases/get_users_usecase.dart';
import 'features/home/presentation/blocs/bloc/user_list_bloc.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(await builder());
}

void main() {
  bootstrap(
    () async {
      AuthLocalData authLocalDataSource = AuthLocalData();
      AuthRepository authRepository = AuthRepositoryImpl(
        authLocalData: authLocalDataSource,
      );

      GetUsersUseCase getUsersUseCase = GetUsersUseCase(
        userRepository: UserRepositoryImpl(userApiDatasources: UserApiDatasources(httpClient: HttpClient())),
      );

      return App(
        authRepository: authRepository,
        authUser: null,
        getUsersUseCase: getUsersUseCase,
      );
    },
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
    this.authUser,
    required this.getUsersUseCase,
  });

  final AuthRepository authRepository;
  final AuthUser? authUser;
  final GetUsersUseCase getUsersUseCase;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserListBloc>(
            create: (context) => UserListBloc(getUsersUseCase),
          ),          
        ],
        child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'ITTI',
        theme: AppTheme().getTheme(),
      ),      
    ));
  }
}