import 'package:app_studiogenesis/navigation/navigation_handler.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavigationHandler implements NavigationHandler {
  @override
  Future goToHomePage(BuildContext context) async {
    return await GoRouter.of(context).push("/");
  }

  @override
  Future goToLoginPage(BuildContext context) async {
    return await GoRouter.of(context).push("/login");
  }
}
