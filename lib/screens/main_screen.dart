import 'package:contactlist/contants/colors.dart';
import 'package:contactlist/models/menus.dart';
import 'package:contactlist/screens/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const String id = "main_screen";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimary,
        automaticallyImplyLeading: false,
        title: const Text(
          'BottomNavigationBar Sample',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: context.watch<ScreenProvider>().getPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: Menus.getMenus(),
        currentIndex: context.watch<ScreenProvider>().selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: kUnselectedMenu,
        backgroundColor: kColorPrimary,
        onTap: (index) {
          context.read<ScreenProvider>().setSelectedIndex(index);
        },
      ),
    );
  }
}
