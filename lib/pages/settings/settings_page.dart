import 'package:app_studiogenesis/di/locator.dart';
import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/navigation/navigation_handler.dart';
import 'package:app_studiogenesis/pages/widgets/settings/settings_container_option.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthManager>(
      create: (context) => AuthManager(isLoginOrRegister: false),
      child: Consumer<AuthManager>(
        builder: (context, manager, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.extraLarge,
                  horizontal: AppDimensions.main),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).settings,
                    style: TextStyle(
                        fontSize: AppDimensions.large,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: AppDimensions.extraLarge),
                  SettingsContainerOption(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 32,
                    ),
                    onContainerPressed: () => locator<NavigationHandler>()
                        .goToUpdateUserPage(context),
                    boxDecoration: BoxDecoration(
                      border: const Border(
                        left: BorderSide(
                            width: 2, color: AppColors.generalBorder),
                        right: BorderSide(
                            width: 2, color: AppColors.generalBorder),
                        top: BorderSide(
                            width: 2, color: AppColors.generalBorder),
                        bottom: BorderSide(
                            width: 1, color: AppColors.generalBorder),
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppDimensions.xmain),
                          topRight: Radius.circular(AppDimensions.xmain)),
                    ),
                    title: S.of(context).personalSettings,
                    subtitle: S.of(context).editPersonalInformation,
                  ),
                  SettingsContainerOption(
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 32,
                    ),
                    onContainerPressed: () => locator<NavigationHandler>()
                        .goToPasswordUpdatePage(context),
                    boxDecoration: BoxDecoration(
                      border: const Border(
                        left: BorderSide(
                            width: 2, color: AppColors.generalBorder),
                        right: BorderSide(
                            width: 2, color: AppColors.generalBorder),
                        top: BorderSide(
                            width: 1, color: AppColors.generalBorder),
                        bottom: BorderSide(
                            width: 2, color: AppColors.generalBorder),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppDimensions.xmain),
                          bottomRight: Radius.circular(AppDimensions.xmain)),
                    ),
                    title: S.of(context).security,
                    subtitle: S.of(context).passwordUpdate,
                  ),
                  SizedBox(height: AppDimensions.large),
                  InkWell(
                    onTap: () {
                      manager.logout();
                      locator<NavigationHandler>().goToHomePage(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: AppColors.loginDisabledText,
                          size: 24,
                        ),
                        SizedBox(width: AppDimensions.small),
                        Text(
                          S.of(context).logout,
                          style: TextStyle(
                              fontSize: AppDimensions.main,
                              fontWeight: FontWeight.w600,
                              color: AppColors.loginDisabledText),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
