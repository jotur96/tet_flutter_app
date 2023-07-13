import '../../data/models/user_model.dart';
import '../repository/user_repository.dart';



class GetUsersUseCase {


  final UserRepository userRepository;

  GetUsersUseCase({
    required this.userRepository
  });


  Future<List<UserModel>> call() {
    return userRepository.getUsers();
  }



}