
import 'package:tet_flutter_app/features/home/data/models/user_model.dart';


abstract class UserRepository {

  Future<List<UserModel>> getUsers();

  Future<UserModel> getUser(int id);



}