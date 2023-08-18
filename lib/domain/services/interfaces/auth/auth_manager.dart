import 'package:app_studiogenesis/domain/models/user/user.dart';
import 'package:app_studiogenesis/domain/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager with ChangeNotifier {
  AuthManager({bool isLoginOrRegister = true, bool isPasswordUpdate = false}) {
    if (isLoginOrRegister) {
      _init();
    } else if (isPasswordUpdate) {
      _getPassword();
    } else {
      _getUser();
    }
  }

  final AuthService authService = AuthService();

  AuthManagerState _currentState = LoadingState();

  User? _user;

  String? _username;
  String? _email;
  String? _usernameToLoginOrRegister = "";
  String? _emailToLoginOrRegister = "";
  String _passwordToLoginOrRegister = "";
  String _passwordToRegisterVerification = "";
  String _name = "";
  String _lastname = "";
  String _birthDate = "";
  String _password = "";
  String _passwordUpdateValidation = "";

  bool _errorPasswordLength = false;
  bool _emailError = false;
  bool _errorPasswordMatch = false;
  bool _errorUsername = false;
  bool _errorLastname = false;
  bool _errorName = false;
  bool _errorBirthdate = false;
  bool _errorPasswordIncorrect = false;

  AuthManagerState get currentState => _currentState;

  User? get user => _user;

  String? get username => _username;
  String? get email => _email;
  String get password => _password;

  bool get errorPasswordLength => _errorPasswordLength;
  bool get errorPasswordIncorrect => _errorPasswordIncorrect;
  bool get emailError => _emailError;
  bool get errorPasswordMatch => _errorPasswordMatch;
  bool get errorUsername => _errorUsername;
  bool get errorLastname => _errorLastname;
  bool get errorName => _errorName;
  bool get errorBirthdate => _errorBirthdate;

  _init() async {
    _currentState = LoadingState();
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    _username = prefs.getString('username');
    _email = prefs.getString('email');

    if (_username == null && _email == null) {
      _currentState = AnonymousUserState();
      notifyListeners();
    } else {
      _me();
    }
  }

  _getPassword() {
    _getPasswordFromLocal();
    _currentState = UpdatePasswordState();
    notifyListeners();
  }

  _getUser() async {
    final res = await authService.me();

    res.fold((l) => null, (r) => _user = r);
    notifyListeners();
  }

  _me() async {
    final res = await authService.me();

    res.fold((l) => _currentState = AnonymousUserState(), (r) {
      _saveInformationInLocal(username: r.username, email: r.email);
      _currentState = UserVerifiedState(r);
    });
    notifyListeners();
  }

  login() async {
    final res = await authService.login(
        email: _email ?? _emailToLoginOrRegister,
        username: _username ?? _usernameToLoginOrRegister,
        password: _passwordToLoginOrRegister);

    res.fold(
        (l) => _currentState =
            ApiErrorState(serverError: l.extensionMessage, message: l.message),
        (r) {
      _saveInformationInLocal(
          token: r.token, username: r.user.username, email: r.user.email);
      _savePasswordInLocal();
      _currentState = UserVerifiedState(r.user);
    });
    notifyListeners();
  }

  bool isUsernameOrEmailNull() {
    return _username == null || _email == null;
  }

  onUsernameOrEmailChanged(String value) {
    if (value.contains('@')) {
      _emailToLoginOrRegister = value;
      _usernameToLoginOrRegister = null;
    } else {
      _usernameToLoginOrRegister = value;
    }
  }

  onPasswordChanged(String value, bool isRegisterInput) {
    if (!isRegisterInput) {
      _passwordToLoginOrRegister = value;
    } else {
      if (value.length >= 2 && value.length <= 8) {
        _errorPasswordLength = true;
      } else {
        _errorPasswordLength = false;
      }
      _passwordToLoginOrRegister = value;
    }
    notifyListeners();
  }

  onVerifyPassword(String value) {
    _passwordToRegisterVerification = value;
    if (_passwordToRegisterVerification != _passwordToLoginOrRegister) {
      _errorPasswordMatch = true;
    } else {
      _errorPasswordMatch = false;
    }
    notifyListeners();
  }

  onNameChanged(String value) {
    _name = value;
  }

  onLastNameChanged(String value) {
    _lastname = value;
  }

  onEmailChanged(String value) {
    _emailToLoginOrRegister = value;
    if (_checkIfEmailIsValid()) {
      _emailError = false;
    } else {
      _emailError = true;
    }
    notifyListeners();
  }

  onUsernameChanged(String value) {
    _usernameToLoginOrRegister = value;
  }

  onUpdatePasswordChanged(String value) {
    _passwordUpdateValidation = value;
  }

  _checkIfEmailIsValid() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_emailToLoginOrRegister!);
  }

  onBirthdaySelected(DateTime value) {
    _birthDate = value.toString();
  }

  onRegisterButtonPressed() async {
    _checkIfNameLastnameBirthdaterUsernameIsNullOrEmpty();
    if (_errorName ||
        _errorLastname ||
        _errorUsername ||
        _errorBirthdate ||
        _errorPasswordLength ||
        _errorPasswordMatch) {
      notifyListeners();
      return null;
    }
    _resetErrorValues();

    final res = await authService.register(
        name: _name,
        lastname: _lastname,
        username: _usernameToLoginOrRegister!,
        birthdate: _birthDate,
        email: _emailToLoginOrRegister!,
        password: _passwordToLoginOrRegister,
        passwordVerified: _passwordToRegisterVerification);

    res.fold(
        (l) => _currentState =
            ApiErrorState(serverError: l.extensionMessage, message: l.message),
        (r) {
      _saveInformationInLocal(
          token: r.token, username: r.user.username, email: r.user.email);
      _savePasswordInLocal();
      _currentState = UserVerifiedState(r.user);
    });
    notifyListeners();
  }

  _resetErrorValues() {
    _errorName = false;
    _errorLastname = false;
    _errorUsername = false;
    _errorPasswordLength = false;
    _errorPasswordMatch = false;
    _errorBirthdate = false;
  }

  logout() async {
    _currentState = LoadingState();
    notifyListeners();

    final res = await authService.logout();

    res.fold(
        (l) => _currentState =
            ApiErrorState(serverError: l.extensionMessage, message: l.message),
        (r) => _currentState = AnonymousUserState());
    notifyListeners();
  }

  _checkIfNameLastnameBirthdaterUsernameIsNullOrEmpty() {
    if (_name.isEmpty) {
      _errorName = true;
    } else {
      _errorName = false;
    }

    if (_lastname.isEmpty) {
      _errorLastname = true;
    } else {
      _errorLastname = false;
    }

    if (_birthDate.isEmpty) {
      _errorBirthdate = true;
    } else {
      _errorBirthdate = false;
    }

    if (_usernameToLoginOrRegister == null ||
        _usernameToLoginOrRegister!.isEmpty) {
      _errorUsername = true;
    } else {
      _errorUsername = false;
    }
  }

  updateUserData() async {
    final res = await authService.updateUser(
      name: (_name.isEmpty) ? null : _name,
      lastname: (_lastname.isEmpty) ? null : _lastname,
      username: (_usernameToLoginOrRegister == "" ||
              _usernameToLoginOrRegister == null)
          ? null
          : _usernameToLoginOrRegister,
      birthdate: (_birthDate.isEmpty) ? null : _birthDate,
      email: (_emailToLoginOrRegister == "" || _emailToLoginOrRegister == null)
          ? null
          : _emailToLoginOrRegister,
    );

    if (res.isLeft()) {
      return res.leftMap((l) => l);
    }

    res.fold((l) => null, (r) {
      _saveInformationInLocal(username: r.username, email: r.email);
      _user = r;
      notifyListeners();
    });
  }

  updatePassword() async {
    if (_checkUpdatePassword()) {
      notifyListeners();
      return null;
    }

    if (_errorPasswordLength || _errorPasswordMatch) {
      notifyListeners();
      return null;
    }

    final res = await authService.updatePassword(
        password: _passwordToLoginOrRegister,
        passwordVerified: _passwordToRegisterVerification);
  
    res.fold(
        (l) => _currentState =
            ApiErrorState(message: l.message, serverError: l.extensionMessage),
        (r) {
      _savePasswordInLocal();
      _currentState = UserVerifiedState(r);
    });
    notifyListeners();
  }

  _savePasswordInLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', _passwordToLoginOrRegister);
  }

  _getPasswordFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _password = prefs.getString('password')!;
  }

  _checkUpdatePassword() {
    if (_password != _passwordUpdateValidation) {
      _errorPasswordIncorrect = true;
    } else {
      _errorPasswordIncorrect = false;
    }
    return _errorPasswordIncorrect;
  }

  _saveInformationInLocal(
      {String? username, String? email, String? token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastUsername = prefs.getString('username');
    String? lastEmail = prefs.getString('email');

    if (username != null) {
      if (lastUsername != username) {
        debugPrint('Guardando username $username');
        prefs.setString('username', username);
      }
    }

    if (email != null) {
      if (lastEmail != null && lastEmail != email) {
        debugPrint('Guardando email $email');
        prefs.setString('email', email);
      }
    }

    if (token != null) {
      debugPrint('Guardando token $token');
      prefs.setString('token', token);
    }
  }

  changeErrorPageStateToAnonymous() {
    _currentState = AnonymousUserState();
    notifyListeners();
  }
}

abstract class AuthManagerState {}

class UpdatePasswordState extends AuthManagerState {}

class LoadingState extends AuthManagerState {}

class UserVerifiedState extends AuthManagerState {
  final User user;
  UserVerifiedState(this.user);
}

class ApiErrorState extends AuthManagerState {
  final String? serverError;
  final String message;
  ApiErrorState({this.serverError, required this.message});
}

class AnonymousUserState extends AuthManagerState {}
