import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/login/login_manager.dart';
import 'package:app_studiogenesis/pages/widgets/input_text.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    return Consumer2<AuthManager, LoginManager>(
      builder: (context, authManager, loginManager, child) {
        return Column(
          children: [
            InputText(
              label: S.of(context).usernameOrEmail,
              inputBackgroundColor: Colors.transparent,
              inputBorderColor: AppColors.secondaryBackgroundLogin,
              initialValue: authManager.username ?? authManager.email,
              placeHolder: authManager.isUsernameOrEmailNull()
                  ? S.of(context).enterEmailOrUsername
                  : null,
              onChangedText: (value) =>
                  authManager.onUsernameOrEmailChanged(value),
            ),
            SizedBox(
              height: AppDimensions.large,
            ),
            InputText(
              label: S.of(context).password,
              inputBackgroundColor: Colors.transparent,
              obscureText: !loginManager.seePasswordInput,
              inputBorderColor: AppColors.secondaryBackgroundLogin,
              sufixIcon: InkWell(
                onTap: () => loginManager.onChangePasswordVisualisationInput(),
                child: loginManager.seePasswordInput
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              placeHolder: S.of(context).enterPassword,
              onChangedText: (value) =>
                  authManager.onPasswordChanged(value, false),
            ),
            SizedBox(height: AppDimensions.extraLarge),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthSize * 0.15),
              child: MainButton(
                onPressed: () => authManager.login(),
                text: S.of(context).signIn,
                expandWidth: true,
                textStyle: TextStyle(
                    fontSize: AppDimensions.main,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }
}
