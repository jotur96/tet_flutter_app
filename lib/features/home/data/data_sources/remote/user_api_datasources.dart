import 'package:tet_flutter_app/core/services/api/http_client.dart';


import '../../../domain/repository/user_repository.dart';
import '../../models/user_model.dart';


class UserApiDatasources extends UserRepository {

  final HttpClient _httpClient;

  UserApiDatasources({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;


  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _httpClient.dio.get('/users');
    return (response.data['data'] as List)
        .map((user) => UserModel.fromJson(user))
        .toList();
  }

  
  @override
  Future<UserModel> getUser(int id) async {
    final response = await _httpClient.dio.get('/users/$id');
    return UserModel.fromJson(response.data);
  }

  
  
  }