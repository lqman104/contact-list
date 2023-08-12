import 'package:contactlist/screens/form.dart';
import 'package:contactlist/screens/user_list.dart';
import 'package:flutter/widgets.dart';

class ScreenProvider extends ChangeNotifier {
  int selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    UserListScreen(),
    FormScreen()
  ];

  static const List<String> _pageTitle = <String>[
    'List User',
    'Create User'
  ];

  Widget getPage() {
    return _widgetOptions[selectedIndex];
  }

  String getPageTitle() {
    return _pageTitle[selectedIndex];
  }

  void setSelectedIndex(int selectedIndex) {
    this.selectedIndex = selectedIndex;
    notifyListeners();
  }

}