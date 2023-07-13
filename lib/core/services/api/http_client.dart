import 'package:dio/dio.dart';
import 'package:tet_flutter_app/core/constants/constants.dart';

class HttpClient {
  final _dio = Dio();
  String url = userAPIBaseURL;

  HttpClient() {
    dio.options.baseUrl = url;
  }

  Dio get dio => _dio;
}