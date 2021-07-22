import 'package:cloud/app/constants/api_links.dart';
import 'package:cloud/app/core/network/api_emo_client.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  late Dio dio;

  AuthRepository() {
    dio = ApiEmoClient().dio;
  }

  Future CheckToken() {
    return Future.value(false);
  }

  Future signIn(
      String username, String password) async {
    Response res;
    Map data = {"email": username, "password": password};
    res = await dio.post(API_AUTH_SIGN_IN, data: data);
    return res;
  }

  Future signUp(String username, String email, String password) async {
    Response res;
    Map data = {
      "username": username,
      "email": email,
      "password": password,
    };
    try {
      res = await dio.post(API_AUTH_SIGN_UP, data: data);
      return res.data;
    } catch (_) {
      return false;
    }
  }
}
