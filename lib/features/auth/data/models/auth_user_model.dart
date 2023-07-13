import 'package:equatable/equatable.dart';
import 'package:tet_flutter_app/features/auth/domain/entities/auth_user.dart';

class AuthUserModel extends Equatable{

  final String username;

  const AuthUserModel({
    required this.username
  });

  AuthUser toAuthUserEntity() => 
      AuthUser(username: username);
      

  @override
  List<Object?> get props => [username];

}