import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print(user.firstName);          
        },
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: GestureDetector(
          onTap: () {
            _launchEmail(context);
          },
          child: Text(
            user.email,
            style: const TextStyle(
              color: Colors.blue, 
            ),
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar),
        ),
      ),
    );
  }

  void _launchEmail(mContext) async {
    ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(
          content: Text('Aplicacion de email no disponible'),
        ),
      );
  }
}
