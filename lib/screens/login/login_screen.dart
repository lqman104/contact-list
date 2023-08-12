import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:contactlist/models/data_response.dart';
import 'package:contactlist/screens/login/login_provider.dart';
import 'package:contactlist/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/form_container.dart';
import '../../components/password_form_field.dart';
import '../../contants/colors.dart';
import '../../contants/styles.dart';
import '../../contants/typhography.dart';

class LoginScreen extends StatelessWidget {
  static const String id = "login_screen";

  const LoginScreen({super.key});

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ModalProgressHUD(
        inAsyncCall: context.watch<LoginProvider>().isLoading,
        child: ListView(
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
                    onChanged: (value) {
                      username = value;
                    },
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PasswordFormField(
                    onChange: (value) {
                      password = value;
                    },
                  ),
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
                onPressed: () async {
                  DataResponse response = await context.read<LoginProvider>()
                      .login(username: username, password: password);

                  if (!context.mounted) return;

                  if (response is Success) {
                    Navigator.of(context).pushReplacementNamed(MainScreen.id);
                  } else if(response is Failed){
                    showSnackbar(context, response.message);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
