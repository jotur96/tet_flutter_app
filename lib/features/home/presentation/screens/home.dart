import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tet_flutter_app/features/home/presentation/widgets/user_card.dart';
import '../blocs/user_bloc/user_list_bloc.dart';

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
        if(! await isGoingBack()) return Future.value(false);
        context.pushReplacement('/');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Lista de Usuarios')),
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
          if (state.users == null) {
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
                return UserCard(
                    user: user,
                    onPressed: (user) {
                      context.push('/userDetail', extra: user);
                    });
              },
              itemCount: state.users!.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<bool> isGoingBack() async {
    bool goingBack = await _alertDialog(); 
    return goingBack;
  }

  Future<bool> _alertDialog() async {
    switch (await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Esta seguro que desea salir?'),
          ),
          title: const Center(child: Text('Logout')),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Salir');
                  }, child: const Text('Salir'),
                ),
                TextButton(
                  onPressed: () {
                   Navigator.pop(context, 'No');
                  }, child: const Text('No'),
                ),
              ],
            ),
          ],
        );
      })) {
        case 'Salir':
          return true;
        case 'No':
          return false;
      }
    return false;
  }
}
