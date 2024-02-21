import 'package:app/constants.dart';
import 'package:dio/dio.dart';

class AuthServices {
  late Dio dio;

  AuthServices() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future signIn(
    String username,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        '$baseUrl/chat/signin/',
        data: {
          'username': username,
          'password': password,
        },
      );
      print(response);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  Future signUp(
    String username,
    String fName,
    String lName,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        '$baseUrl/chat/signup/',
        data: {
          'username': username,
          'first_name': fName,
          'last_name': lName,
          'password': password,
        },
      );
      print(response);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }
}
