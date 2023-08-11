import 'package:flutter/widgets.dart';

class ScreenProvider extends ChangeNotifier {
  int selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  Widget getPage() {
    return _widgetOptions[selectedIndex];
  }

  void setSelectedIndex(int selectedIndex) {
    this.selectedIndex = selectedIndex;
    notifyListeners();
  }



}