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

  /// `Introduce your new password`
  String get enterNewPassword {
    return Intl.message(
      'Introduce your new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
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

  /// `Write the new name`
  String get writeNewTicketName {
    return Intl.message(
      'Write the new name',
      name: 'writeNewTicketName',
      desc: '',
      args: [],
    );
  }

  /// `Ticket name`
  String get ticketName {
    return Intl.message(
      'Ticket name',
      name: 'ticketName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Write the new description`
  String get writeNewDescription {
    return Intl.message(
      'Write the new description',
      name: 'writeNewDescription',
      desc: '',
      args: [],
    );
  }

  /// `Event date`
  String get eventDate {
    return Intl.message(
      'Event date',
      name: 'eventDate',
      desc: '',
      args: [],
    );
  }

  /// `Choose the new date`
  String get chooseeEventDate {
    return Intl.message(
      'Choose the new date',
      name: 'chooseeEventDate',
      desc: '',
      args: [],
    );
  }

  /// `Ticket price`
  String get ticketPrice {
    return Intl.message(
      'Ticket price',
      name: 'ticketPrice',
      desc: '',
      args: [],
    );
  }

  /// `Write the new price`
  String get writeTicketPrice {
    return Intl.message(
      'Write the new price',
      name: 'writeTicketPrice',
      desc: '',
      args: [],
    );
  }

  /// `Update ticket`
  String get updateTicket {
    return Intl.message(
      'Update ticket',
      name: 'updateTicket',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get preview {
    return Intl.message(
      'Preview',
      name: 'preview',
      desc: '',
      args: [],
    );
  }

  /// `Edit ticket`
  String get editTicket {
    return Intl.message(
      'Edit ticket',
      name: 'editTicket',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Everithing went well 😊!`
  String get everithingWentWell {
    return Intl.message(
      'Everithing went well 😊!',
      name: 'everithingWentWell',
      desc: '',
      args: [],
    );
  }

  /// `Create ticket`
  String get createTicket {
    return Intl.message(
      'Create ticket',
      name: 'createTicket',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Personal settings`
  String get personalSettings {
    return Intl.message(
      'Personal settings',
      name: 'personalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Edit personal information`
  String get editPersonalInformation {
    return Intl.message(
      'Edit personal information',
      name: 'editPersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Password update`
  String get passwordUpdate {
    return Intl.message(
      'Password update',
      name: 'passwordUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get passwordIncorrect {
    return Intl.message(
      'Incorrect password',
      name: 'passwordIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Update password`
  String get updateUser {
    return Intl.message(
      'Update password',
      name: 'updateUser',
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
