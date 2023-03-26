import 'package:flutter/foundation.dart';

class ThemeProvider with ChangeNotifier {
  bool isDark = false;
  switchMode() {
    isDark = !isDark;
    notifyListeners();
  }
}
