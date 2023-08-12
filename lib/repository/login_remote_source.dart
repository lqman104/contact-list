import 'package:contactlist/network/network_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../network/network.dart';

class LoginRemoteSource {
  Future<User> login({
    required String username,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'user': username,
        'password': password,
      });
      var response = await dio.post(
        '/login',
        data: formData,
      );
      return User.fromJson(response.data);
    } on DioException catch (err) {
      if(kDebugMode) print(err);
      final errorMessage = NetworkException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if(kDebugMode) print(e);
      throw e.toString();
    }
  }
}
