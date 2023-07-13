import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    userListBloc.add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    print("BuildBody...");
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) {
        print("builder: ${state.users}");
        // if(state.users == null) {
        //   userListBloc.add(GetUsersEvent());
        // }
        if (state is UserListLoading) {
          print('state is Loading');
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is UserListError) {
          return Center(
            child: IconButton(
              icon:const Icon(Icons.refresh),
              onPressed:() {
                userListBloc.add(GetUsersEvent());
              },
            ),
          );
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
    );
  }
}
