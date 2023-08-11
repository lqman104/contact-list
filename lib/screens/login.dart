import 'package:contactlist/screens/main_screen.dart';
import 'package:flutter/material.dart';

import '../components/password_form_field.dart';
import '../contants/colors.dart';
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    color: Colors.white,
                    boxShadow: [BoxShadow()]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Username',
                          prefixIconColor: Colors.grey.shade300,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.person_outline),
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
              ),
            ),
          ),
          FilledButton(
            child: const Text('Login'),
            onPressed: () {
              Navigator.pushNamed(context, MainScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
