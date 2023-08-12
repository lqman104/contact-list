import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:contactlist/screens/main_screen.dart';
import 'package:flutter/material.dart';

import '../components/form_container.dart';
import '../components/password_form_field.dart';
import '../contants/colors.dart';
import '../contants/styles.dart';
import '../contants/typhography.dart';

class LoginScreen extends StatelessWidget {
  static const String id = "login_screen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
            child: Image.asset(
              'images/tonjoo.png',
              width: 80,
              height: 80,
            ),
          ),
          Text(
            'Login',
            style: kTitleLargeStyle.copyWith(color: kColorPrimary),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Silahkan login gunakan username dan password',
            textAlign: TextAlign.center,
          ),
          FormContainer(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: Styles.getIconInputDecoration(
                    hint: 'Username',
                    iconData: Icons.person_outline,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade300,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: PasswordFormField(),
              )
            ],
          ),
          ConnectivityWidgetWrapper(
            stacked: false,
            offlineWidget: const FilledButton(
              onPressed: null,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: FilledButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, MainScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
