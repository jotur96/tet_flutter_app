
import '../models/auth_user_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalData extends AuthLocalDataSource{
  @override
  Future<AuthUserModel> signInWithUsernameAndPassword({
    required String username,
    required String password}) 
  async {
    await Future.delayed(const Duration(seconds: 1));
    return AuthUserModel(username: username);
  }

  
}

