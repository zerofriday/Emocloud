import 'package:cloud/app/core/network/api_client.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  late Dio dio;

  AuthRepository() {
    dio = ApiClient().dio;
  }

  Future signIn(String username, String password) {
    return Future.value(false);
  }

  Future signUp(String username, String email, String password) {
    return Future.value(false);
  }
}
