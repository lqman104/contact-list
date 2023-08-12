import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:contactlist/repository/login/login_local_source.dart';
import 'package:contactlist/repository/login/login_remote_source.dart';
import 'package:contactlist/repository/login/login_repository.dart';
import 'package:contactlist/repository/user/user_local_source.dart';
import 'package:contactlist/repository/user/user_remote_source.dart';
import 'package:contactlist/repository/user/user_repository.dart';
import 'package:contactlist/screens/contact/contact_provider.dart';
import 'package:contactlist/screens/login/login_provider.dart';
import 'package:contactlist/screens/login/login_screen.dart';
import 'package:contactlist/screens/main_screen.dart';
import 'package:contactlist/screens/screen_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loginRepository = LoginRepository(
    LoginLocalSource(),
    LoginRemoteSource(),
  );

  final contactRepository = ContactRepository(
    ContactLocalSource(),
    ContactRemoteSource(),
  );

  final bool isLoggedIn = await loginRepository.isLoggedIn();
  late final String initialRoute;
  try {
    if (isLoggedIn) {
      initialRoute = MainScreen.id;
    } else {
      initialRoute = LoginScreen.id;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    initialRoute = LoginScreen.id;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenProvider()),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(
            loginRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(
            contactRepository,
          ),
        ),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

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
        initialRoute: initialRoute,
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          MainScreen.id: (context) => const MainScreen(),
        },
      ),
    );
  }
}
