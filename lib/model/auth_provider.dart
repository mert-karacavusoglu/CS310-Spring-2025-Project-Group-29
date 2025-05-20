import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';


class AuthInfoProvider extends ChangeNotifier {
  bool authenticationState = false;
  bool get authState => authenticationState;

  void setAuth(bool state) {
    authenticationState = state;
    notifyListeners();
  }

}