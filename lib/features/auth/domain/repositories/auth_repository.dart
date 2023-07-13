import '../entities/auth_user.dart';

abstract class AuthRepository {

  Future<AuthUser> signIn({
    required String username,
    required String password,
  });

}