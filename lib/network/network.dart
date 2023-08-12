import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: 'http://192.168.1.4:3001',
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 15),
);

final Dio dio = Dio(options);
