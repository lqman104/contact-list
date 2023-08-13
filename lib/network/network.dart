import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: 'https://test-android.tongkolspace.com',
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 15),
);

final Dio dio = Dio(options);
