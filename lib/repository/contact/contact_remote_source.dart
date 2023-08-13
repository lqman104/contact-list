import 'package:contactlist/network/network_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/contact.dart';
import '../../network/network.dart';

class ContactRemoteSource {
  Future<List<Contact>> fetch() async {
    try {
      var response = await dio.get('/users');
      return (response.data as List)
          .map((x) => Contact.fromJson(x))
          .toList();
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
