import 'dart:convert' as convert;

import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:contactlist/repository/login_local_source.dart';
import 'package:contactlist/repository/login_remote_source.dart';
import 'package:contactlist/repository/login_repository.dart';
import 'package:contactlist/screens/login/login_screen.dart';
import 'package:contactlist/screens/login/login_provider.dart';
import 'package:contactlist/screens/main_screen.dart';
import 'package:contactlist/screens/screen_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contants/colors.dart';
import 'network/network.dart';

/// Must be top-level function
Map<String, dynamic> _parseAndDecode(String response) {
  return convert.jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() {
  dio.transformer = BackgroundTransformer()..jsonDecodeCallback = parseJson;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenProvider()),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(
            LoginRepository(
              LoginLocalSource(),
              LoginRemoteSource(),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kColorPrimary,
            secondary: kColorPrimary,
          ),
          buttonTheme: Theme.of(context)
              .buttonTheme
              .copyWith(buttonColor: kColorPrimary),
          useMaterial3: true,
        ),
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          MainScreen.id: (context) => const MainScreen(),
        },
      ),
    );
  }
}
