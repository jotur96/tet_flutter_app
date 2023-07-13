import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../values_objects/password.dart';
import '../values_objects/username.dart';

class SignInUseCase {
  
  final AuthRepository authRepository;

  SignInUseCase({
    required this.authRepository
  });

  Future<AuthUser> call(SignInParams params) async {
    try {
      return await authRepository.signIn(
        username: params.username.value,
        password: params.password.value,
      );
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class SignInParams {
  final Username username;
  final Password password;

  SignInParams({
    required this.username,
    required this.password,
  });


}



