import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
      builder: (context, manager, child) {
        return TextButton(
            onPressed: () => manager.logout(), child: const Text('Logout'));
      },
    );
  }
}
