import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/navigation/navigation_handler.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavigationHandler implements NavigationHandler {
  @override
  Future goToHomePage(BuildContext context) async {
    return await GoRouter.of(context).pushReplacement("/");
  }
  
  @override
  Future goToLoginPage(BuildContext context) async {
    return await GoRouter.of(context).pushReplacement("/login");
  }

  @override
  Future goToEditScaffoldPage(BuildContext context, Ticket ticket) async {
    return await GoRouter.of(context).push("/ticket/edit", extra: ticket);
  }

  @override
  Future goToPasswordUpdatePage(BuildContext context) async {
    return await GoRouter.of(context).push("/settings/password");
  }

  @override
  Future goToUpdateUserPage(BuildContext context) async {
    return await GoRouter.of(context).push("/settings/profile");
  }
}
