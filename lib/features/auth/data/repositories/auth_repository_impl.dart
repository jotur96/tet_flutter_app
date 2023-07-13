import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthLocalData authLocalData;

  const AuthRepositoryImpl({
    required this.authLocalData
  });


  @override
  Future<AuthUser> signIn (
    {required String username, 
    required String password
    }) async {

    final authModel = await authLocalData.signInWithUsernameAndPassword(
      username: username,
      password: password,
    );

    return authModel.toAuthUserEntity();
  }




}
