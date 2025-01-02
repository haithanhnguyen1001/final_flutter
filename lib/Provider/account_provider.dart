import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  String? _accessToken;

  String? get accessToken => _accessToken;

  void login(String token) {
    _accessToken = token;
    notifyListeners();
  }

  void logout() {
    _accessToken = null;
    notifyListeners();
  }
}
