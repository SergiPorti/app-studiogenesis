import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/login/login_manager.dart';
import 'package:app_studiogenesis/pages/widgets/login/login_form.dart';
import 'package:app_studiogenesis/pages/widgets/login/register_form.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: ChangeNotifierProvider<LoginManager>(
        create: (context) => LoginManager(),
        child: Consumer2<AuthManager, LoginManager>(
          builder: (context, authManager, loginManager, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size * 0.1, horizontal: AppDimensions.main),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => loginManager.onSignInPressed(true),
                          child: Container(
                            decoration: BoxDecoration(
                                color: loginManager.signInState
                                    ? AppColors.secondaryBackgroundLogin
                                    : AppColors.loginDisabledBackground,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppDimensions.large),
                                  bottomLeft:
                                      Radius.circular(AppDimensions.large),
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(AppDimensions.small),
                              child: Text(
                                S.of(context).signIn,
                                style: TextStyle(
                                    color: loginManager.signInState
                                        ? Colors.white
                                        : AppColors.loginDisabledText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => loginManager.onSignInPressed(false),
                          child: Container(
                            decoration: BoxDecoration(
                              color: !loginManager.signInState
                                  ? AppColors.secondaryBackgroundLogin
                                  : AppColors.loginDisabledBackground,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(AppDimensions.large),
                                bottomRight:
                                    Radius.circular(AppDimensions.large),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(AppDimensions.small),
                              child: Text(
                                S.of(context).signUp,
                                style: TextStyle(
                                    color: !loginManager.signInState
                                        ? Colors.white
                                        : AppColors.loginDisabledText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size * 0.15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => loginManager.onSignInPressed(true),
                                child: Container(
                                    decoration: loginManager.signInState
                                        ? const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: AppColors
                                                        .secondaryBackgroundLogin,
                                                    width: 2)),
                                          )
                                        : null,
                                    child: Text(
                                      S.of(context).signIn,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: loginManager.signInState
                                                ? Colors.white
                                                : AppColors.loginDisabledText,
                                          ),
                                    )),
                              ),
                              SizedBox(width: AppDimensions.main),
                              Text(
                                S.of(context).or,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(width: AppDimensions.main),
                              GestureDetector(
                                onTap: () =>
                                    loginManager.onSignInPressed(false),
                                child: Container(
                                    decoration: !loginManager.signInState
                                        ? const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: AppColors
                                                        .secondaryBackgroundLogin,
                                                    width: 2)),
                                          )
                                        : null,
                                    child: Text(
                                      S.of(context).signUp,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: !loginManager.signInState
                                                ? Colors.white
                                                : AppColors.loginDisabledText,
                                          ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppDimensions.extraLarge,
                          ),
                          loginManager.signInState
                              ? const LoginForm()
                              : const RegisterForm()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
