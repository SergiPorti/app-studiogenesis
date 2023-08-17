// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `HelloWorld`
  String get helloWorld {
    return Intl.message(
      'HelloWorld',
      name: 'helloWorld',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Enter your username or email`
  String get enterEmailOrUsername {
    return Intl.message(
      'Enter your username or email',
      name: 'enterEmailOrUsername',
      desc: '',
      args: [],
    );
  }

  /// `Username or email`
  String get usernameOrEmail {
    return Intl.message(
      'Username or email',
      name: 'usernameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Introduce your password`
  String get enterPassword {
    return Intl.message(
      'Introduce your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Write your name`
  String get namePlaceholder {
    return Intl.message(
      'Write your name',
      name: 'namePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Lastname`
  String get lastname {
    return Intl.message(
      'Lastname',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// `Write your lastname`
  String get lastnamePlaceholder {
    return Intl.message(
      'Write your lastname',
      name: 'lastnamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `example@gmail.com`
  String get emailPlaceholder {
    return Intl.message(
      'example@gmail.com',
      name: 'emailPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Birthdate`
  String get birthdate {
    return Intl.message(
      'Birthdate',
      name: 'birthdate',
      desc: '',
      args: [],
    );
  }

  /// `Choose your birthdate`
  String get birthdatePlaceholder {
    return Intl.message(
      'Choose your birthdate',
      name: 'birthdatePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Repeat your password`
  String get repeatPassword {
    return Intl.message(
      'Repeat your password',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `ExampleUsername`
  String get usernameExample {
    return Intl.message(
      'ExampleUsername',
      name: 'usernameExample',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get emailError {
    return Intl.message(
      'Invalid email',
      name: 'emailError',
      desc: '',
      args: [],
    );
  }

  /// `Password must have more than 8 letters`
  String get errorPasswordLength {
    return Intl.message(
      'Password must have more than 8 letters',
      name: 'errorPasswordLength',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get errorValidatePassword {
    return Intl.message(
      'Passwords do not match',
      name: 'errorValidatePassword',
      desc: '',
      args: [],
    );
  }

  /// `This field can not be empty`
  String get fieldCanNotBeEmpty {
    return Intl.message(
      'This field can not be empty',
      name: 'fieldCanNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong 😣`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong 😣',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Back to login page`
  String get backToLoginPage {
    return Intl.message(
      'Back to login page',
      name: 'backToLoginPage',
      desc: '',
      args: [],
    );
  }

  /// `Search ticket`
  String get searchTicket {
    return Intl.message(
      'Search ticket',
      name: 'searchTicket',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Go back`
  String get goBack {
    return Intl.message(
      'Go back',
      name: 'goBack',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
