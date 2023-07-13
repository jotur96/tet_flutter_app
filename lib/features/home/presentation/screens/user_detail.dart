import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';


class UserDetail extends StatelessWidget {
  final UserModel user;
  const UserDetail({super.key, required this.user});  

  @override
  Widget build(BuildContext context) {
    final int randomNumber = generateRandomNumber();
    print('$randomNumber');
    String statusText;

    if (randomNumber < 20) {
      statusText = 'Activo';
    } else if (randomNumber % 20 == 0) {
      statusText = 'Inactivo';
    } else {
      statusText = 'Bloqueado';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Detalle del ususario')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            sizedBox(),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatar),
            ),
            sizedBox(),
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 30),
            ),
            sizedBox(),
            GestureDetector(
              onTap: () {
                _launchEmail(context);
              },
              child: Text(
                user.email,
                style: const TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
            sizedBox(),
            Text(
              'Usuario $statusText',
            ),
          ],
        ),
      ),
    );
  }

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(101);
  }

  void _launchEmail(mContext) async {
    ScaffoldMessenger.of(mContext).showSnackBar(
      const SnackBar(
        content: Text('Aplicacion de email no disponible'),
      ),
    );
  }

  SizedBox sizedBox() {
    return const SizedBox(
      height: 20,
    );
  }
}
