import 'package:flutter/material.dart';

class LoginManager with ChangeNotifier {
  bool _signInState = true;
  bool _seePasswordInput = false;

  bool get signInState => _signInState;
  bool get seePasswordInput => _seePasswordInput;

  onSignInPressed(bool isSignInButtonPressed) {
    if (_signInState != isSignInButtonPressed) {
      _signInState = !_signInState;
      notifyListeners();
    }
  }

  onChangePasswordVisualisationInput() {
    _seePasswordInput = !_seePasswordInput;
    notifyListeners();
  }
}
