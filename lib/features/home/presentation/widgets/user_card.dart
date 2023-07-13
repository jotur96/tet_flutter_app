import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final Function(UserModel) onPressed;

  const UserCard({super.key, required this.user, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(user.avatar),
        ),
        onTap: () {
          onPressed(user);
        },
        title: Column(
          children: [
            const SizedBox(height: 10),
            Text('${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 20),),
            const SizedBox(height: 10),
          ],
        ),
        subtitle: GestureDetector(
          onTap: () {
            _launchEmail(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                user.email,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20
                ),                
              ),
              const SizedBox(height: 10,),
            ],
          ),
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
