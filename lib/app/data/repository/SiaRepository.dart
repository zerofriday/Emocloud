import 'package:cloud/app/core/network/api_client.dart';
import 'package:dio/dio.dart';

class SiaRepository {
  late Dio dio;

  SiaRepository() {
    dio = ApiClient().dio;
  }
}
