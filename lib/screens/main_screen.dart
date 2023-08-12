import 'package:contactlist/contants/colors.dart';
import 'package:contactlist/models/menus.dart';
import 'package:contactlist/screens/screen_provider.dart';
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
            onTap: (index) {
              if (index == 2) {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
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
