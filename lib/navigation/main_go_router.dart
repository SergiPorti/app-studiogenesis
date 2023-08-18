import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/pages/home/home_page.dart';
import 'package:app_studiogenesis/pages/login/login_page.dart';
import 'package:app_studiogenesis/pages/main_page.dart';
import 'package:app_studiogenesis/pages/settings/settings_page.dart';
import 'package:app_studiogenesis/pages/settings/settings_update_password.dart';
import 'package:app_studiogenesis/pages/settings/settings_update_user.dart';
import 'package:app_studiogenesis/pages/ticket/edit/edit_ticket_page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainGoRouter {
  MainGoRouter() {
    _buildRouter();
  }

  late GoRouter _router;

  GoRouter get router => _router;
  final List<NavigatorObserver> observers = [];

  _buildRouter() {
    _router = GoRouter(
      observers: observers,
      routes: <GoRoute>[
        GoRoute(
          path: "/",
          builder: (context, state) {
            return const MainPage();
          },
        ),
        GoRoute(
          path: "/login",
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
            path: "/settings",
            builder: (context, state) {
              return const SettingsPage();
            },
            routes: [
              GoRoute(
                path: "profile",
                builder: (context, state) {
                  return SettingsUpdateUser();
                },
              ),
              GoRoute(
                path: "password",
                builder: (context, state) {
                  return const SettingsUpdatePassword();
                },
              )
            ]),
        GoRoute(
            path: "/ticket",
            builder: (context, state) {
              return const HomePage();
            },
            routes: [
              GoRoute(
                path: "edit",
                builder: (context, state) {
                  final Ticket ticket = state.extra as Ticket;
                  return EditTicketPageScaffold(ticket);
                },
              )
            ])
      ],
    );
  }
}
