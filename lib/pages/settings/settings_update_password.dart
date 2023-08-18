import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/widgets/appbar/app_bar_default.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsUpdatePassword extends StatelessWidget {
  const SettingsUpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(title: Text(S.of(context).passwordUpdate)),
      backgroundColor: AppColors.generalBackground,
      body: ChangeNotifierProvider<AuthManager>(
        create: (context) =>
            AuthManager(isLoginOrRegister: false, isPasswordUpdate: true),
        child: Consumer<AuthManager>(
          builder: (context, manager, child) {
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.extraLarge,
                  horizontal: AppDimensions.main),
              child: Text('Password'),
            ));
          },
        ),
      ),
    );
  }
}
