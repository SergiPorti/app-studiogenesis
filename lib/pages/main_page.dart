import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/pages/error/error_page.dart';
import 'package:app_studiogenesis/pages/home/home_page.dart';
import 'package:app_studiogenesis/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthManager>(
      create: (context) => AuthManager(),
      builder: (context, child) {
        return Consumer<AuthManager>(
          builder: (context, manager, child) {
            switch (manager.currentState.runtimeType) {
              case AnonymousUserState:
                return const LoginPage();
              case UserVerifiedState:
                return const HomePage();
              case LoadingState:
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              case ApiErrorState:
                return const ErrorPage();
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
