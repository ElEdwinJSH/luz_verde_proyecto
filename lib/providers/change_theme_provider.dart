import 'package:flutter/cupertino.dart';

class ChangeTheme with ChangeNotifier {
  bool _isdarktheme = true;

  bool get isdarktheme => _isdarktheme;

  set isdarktheme(bool _) {
    _isdarktheme = _;
    notifyListeners();
  }
}
