import 'package:app_studiogenesis/pages/login/login_page.dart';
import 'package:app_studiogenesis/pages/main_page.dart';
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
      ],
    );
  }
}
