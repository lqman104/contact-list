import 'package:flutter/material.dart';

class Menus {
  static List<BottomNavigationBarItem> getMenus() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.edit),
        label: 'Add new',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.exit_to_app),
        label: 'Logout',
      )
    ];
  }
}