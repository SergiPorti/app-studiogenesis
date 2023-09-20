import 'package:app_studiogenesis/di/locator.dart';
import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/navigation/navigation_handler.dart';
import 'package:app_studiogenesis/pages/login/login_manager.dart';
import 'package:app_studiogenesis/pages/widgets/appbar/app_bar_default.dart';
import 'package:app_studiogenesis/pages/widgets/error/custom_error_widget.dart';
import 'package:app_studiogenesis/pages/widgets/input_text.dart';
import 'package:app_studiogenesis/pages/widgets/popup/default_popup.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsUpdatePassword extends StatelessWidget {
  const SettingsUpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(title: Text(S.of(context).passwordUpdate)),
      backgroundColor: AppColors.generalBackground,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthManager>(
              create: (_) => AuthManager(
                  isLoginOrRegister: false, isPasswordUpdate: true)),
          ChangeNotifierProvider<LoginManager>(create: (_) => LoginManager())
        ],
        child: Consumer2<AuthManager, LoginManager>(
          builder: (context, manager, loginManager, child) {
            switch (manager.currentState.runtimeType) {
              case LoadingState:
                return const Center(child: CircularProgressIndicator());
              case ApiErrorState:
                final String message =
                    (manager.currentState as ApiErrorState).message;
                final String? extensionMessage =
                    (manager.currentState as ApiErrorState).serverError;
                return CustomErrorWidget(
                    message: message,
                    extensionMessage: extensionMessage,
                    onButtonPressed: () =>
                        locator<NavigationHandler>().goToHomePage(context));
              case UserVerifiedState || UpdatePasswordState:
                return SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.extraLarge,
                      horizontal: AppDimensions.main),
                  child: Column(
                    children: [
                      InputText(
                        label: S.of(context).enterPassword,
                        inputBackgroundColor: Colors.transparent,
                        obscureText: true,
                        inputBorderColor: AppColors.secondaryBackgroundLogin,
                        errorText: manager.errorPasswordIncorrect
                            ? S.of(context).passwordIncorrect
                            : null,
                        placeHolder: S.of(context).password,
                        onChangedText: (value) =>
                            manager.onUpdatePasswordChanged(value),
                      ),
                      SizedBox(height: AppDimensions.main),
                      InputText(
                        label: S.of(context).password,
                        inputBackgroundColor: Colors.transparent,
                        obscureText: !loginManager.seePasswordInput,
                        inputBorderColor: AppColors.secondaryBackgroundLogin,
                        errorText: manager.errorPasswordLength
                            ? S.of(context).errorPasswordLength
                            : null,
                        sufixIcon: InkWell(
                          onTap: () =>
                              loginManager.onChangePasswordVisualisationInput(),
                          child: loginManager.seePasswordInput
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        placeHolder: S.of(context).enterNewPassword,
                        onChangedText: (value) =>
                            manager.onPasswordChanged(value, true),
                      ),
                      SizedBox(
                        height: AppDimensions.large,
                      ),
                      InputText(
                        inputBackgroundColor: Colors.transparent,
                        obscureText: !loginManager.seePasswordInput,
                        inputBorderColor: AppColors.secondaryBackgroundLogin,
                        sufixIcon: InkWell(
                          onTap: () =>
                              loginManager.onChangePasswordVisualisationInput(),
                          child: loginManager.seePasswordInput
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        placeHolder: S.of(context).repeatPassword,
                        errorText: manager.errorPasswordMatch
                            ? S.of(context).errorValidatePassword
                            : null,
                        onChangedText: (value) =>
                            manager.onVerifyPassword(value),
                      ),
                      SizedBox(height: AppDimensions.extraLarge),
                      MainButton(
                        color: AppColors.secondaryBackgroundLogin,
                        expandWidth: true,
                        textStyle: TextStyle(
                            fontSize: AppDimensions.main,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        text: S.of(context).passwordUpdate,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          await manager.updatePassword().then((value) {
                            if (manager.currentState is UserVerifiedState) {
                              defaultPopupAsync(context,
                                  title: S.of(context).congratulations,
                                  description: S.of(context).everithingWentWell,
                                  mainButtonText: S.of(context).goBack,
                                  mainbuttonPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            }
                          });
                        },
                      )
                    ],
                  ),
                ));
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
