

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar
  });

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
    id: data['id'],
    email: data['email'],
    firstName: data['first_name'],
    lastName: data['last_name'],
    avatar: data['avatar'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'avatar': avatar
  };


  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];

}