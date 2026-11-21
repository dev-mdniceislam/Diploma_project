import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthState extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn(bool value) {
    if (_isLoggedIn == value) return;
    _isLoggedIn = value;
    notifyListeners(); // router কে জানায় যে redirect আবার চালাতে হবে
  }
}

final authStateProvider = ChangeNotifierProvider<AuthState>(
  (ref) => AuthState(),
);
