import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:flutter/material.dart';

abstract class NavigationHandler {
  Future goToHomePage(BuildContext context);
  Future goToLoginPage(BuildContext context);
  Future goToEditScaffoldPage(BuildContext context, Ticket ticket);
  Future goToUpdateUserPage(BuildContext context);
  Future goToPasswordUpdatePage(BuildContext context);
}
