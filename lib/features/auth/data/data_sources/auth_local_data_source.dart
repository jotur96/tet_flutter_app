import '../models/auth_user_model.dart';

abstract class AuthLocalDataSource {

  Future<AuthUserModel> signInWithUsernameAndPassword({
    required String username,
    required String password,
  });

}
