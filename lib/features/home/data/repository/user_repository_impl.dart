import 'package:tet_flutter_app/features/home/data/data_sources/remote/user_api_datasources.dart';
import '../../domain/repository/user_repository.dart';
import '../models/user_model.dart';


class UserRepositoryImpl implements UserRepository {

  final UserApiDatasources userApiDatasources;

  UserRepositoryImpl({
    required this.userApiDatasources
  });
  
  @override
  Future<List<UserModel>> getUsers() async {
    return await userApiDatasources.getUsers();    
  }
  
  @override
  Future<UserModel> getUser(int id) async {
    return await userApiDatasources.getUser(id);
  }

}