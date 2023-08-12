import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:contactlist/screens/login/login.dart';
import 'package:contactlist/screens/main_screen.dart';
import 'package:contactlist/screens/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contants/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenProvider()),
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
