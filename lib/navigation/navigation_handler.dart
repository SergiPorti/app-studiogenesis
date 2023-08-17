import 'package:flutter/material.dart';

abstract class NavigationHandler {
  Future goToHomePage(BuildContext context);

  Future goToLoginPage(BuildContext context);
}