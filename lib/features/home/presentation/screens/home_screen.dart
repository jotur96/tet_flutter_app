import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:tet_flutter_app/features/home/presentation/blocs/user_list_bloc/user_list_bloc.dart';

import '../blocs/bloc/user_list_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserListBloc userListBloc;

  @override
  void initState() {
    super.initState();
    userListBloc = BlocProvider.of<UserListBloc>(context);
    userListBloc.add(const GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement('/');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Usuarios'),
          automaticallyImplyLeading: false,
        ),
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
      userListBloc.add(const GetUsersEvent());
      },
      child: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if(state.users == null) {
            print('state.users');
            userListBloc.add(const GetUsersEvent());
          }
          if (state is UserListLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is UserListError) {
            // userListBloc.add(const GetUsersEvent());
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is UserListDone) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final user = state.users![index];
                return ListTile(
                  title: Text(user.firstName),
                  subtitle: Text(user.email),
                );
              },
              itemCount: state.users!.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
