import '../../data/models/user_model.dart';
import '../repository/user_repository.dart';



class GetUserIdUseCase {

  final UserRepository userRepository;

  GetUserIdUseCase({
    required this.userRepository
  });

  Future<UserModel> call(int id) {
    return userRepository.getUser(id);
  }


}