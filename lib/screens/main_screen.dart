import 'package:contactlist/contants/colors.dart';
import 'package:contactlist/models/data_response.dart';
import 'package:contactlist/models/menus.dart';
import 'package:contactlist/screens/login/login_provider.dart';
import 'package:contactlist/screens/screen_provider.dart';
import 'package:contactlist/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login/login_screen.dart';

class MainScreen extends StatelessWidget {
  static const String id = "main_screen";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenProvider>(
      builder: (context, data, widget) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kColorPrimary,
            automaticallyImplyLeading: false,
            title: Text(
              data.getPageTitle(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: data.getPage(),
          bottomNavigationBar: BottomNavigationBar(
            items: Menus.getMenus(),
            currentIndex: data.selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: kUnselectedMenu,
            backgroundColor: kColorPrimary,
            onTap: (index) async {
              if (index == 2) {
                DataResponse response = await context.read<LoginProvider>().logout();

                if(!context.mounted) return;

                if(response is Success) {
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                } else {
                  showMySnackbar(context, "Failed to logout");
                }

                return;
              }

              data.setSelectedIndex(index);
            },
          ),
        );
      },
    );
  }
}
