import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/language/language_manager.dart';
import 'package:app_studiogenesis/pages/login/login_manager.dart';
import 'package:app_studiogenesis/pages/widgets/input_text.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<LanguageManager>(
      create: (context) => LanguageManager(),
      child: Consumer2<AuthManager, LoginManager>(
        builder: (context, authManager, loginManager, child) {
          return Column(
            children: [
              InputText(
                label: S.of(context).name,
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                errorText: authManager.errorName
                    ? S.of(context).fieldCanNotBeEmpty
                    : null,
                placeHolder: S.of(context).namePlaceholder,
                onChangedText: (value) => authManager.onNameChanged(value),
              ),
              SizedBox(height: AppDimensions.main),
              InputText(
                label: S.of(context).lastname,
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                placeHolder: S.of(context).lastnamePlaceholder,
                errorText: authManager.errorLastname
                    ? S.of(context).fieldCanNotBeEmpty
                    : null,
                onChangedText: (value) => authManager.onLastNameChanged(value),
              ),
              SizedBox(height: AppDimensions.main),
              InputText(
                label: S.of(context).username,
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                placeHolder: S.of(context).usernameExample,
                errorText: authManager.errorUsername
                    ? S.of(context).fieldCanNotBeEmpty
                    : null,
                onChangedText: (value) => authManager.onUsernameChanged(value),
              ),
              SizedBox(height: AppDimensions.main),
              InputText(
                label: S.of(context).email,
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                placeHolder: S.of(context).emailPlaceholder,
                errorText:
                    authManager.emailError ? S.of(context).emailError : null,
                onChangedText: (value) => authManager.onEmailChanged(value),
              ),
              SizedBox(
                height: AppDimensions.main,
              ),
              InputText(
                label: S.of(context).birthdate,
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                placeHolder: S.of(context).birthdatePlaceholder,
                errorText: authManager.errorBirthdate
                    ? S.of(context).fieldCanNotBeEmpty
                    : null,
                controller: _dateController,
                readOnly: true,
                onTap: () => _displayDatePicker(context, authManager),
              ),
              SizedBox(
                height: AppDimensions.large,
              ),
              InputText(
                label: S.of(context).password,
                inputBackgroundColor: Colors.transparent,
                obscureText: !loginManager.seePasswordInput,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                errorText: authManager.errorPasswordLength
                    ? S.of(context).errorPasswordLength
                    : null,
                sufixIcon: InkWell(
                  onTap: () =>
                      loginManager.onChangePasswordVisualisationInput(),
                  child: loginManager.seePasswordInput
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
                placeHolder: S.of(context).enterPassword,
                onChangedText: (value) =>
                    authManager.onPasswordChanged(value, true),
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
                errorText: authManager.errorPasswordMatch
                    ? S.of(context).errorValidatePassword
                    : null,
                onChangedText: (value) => authManager.onVerifyPassword(value),
              ),
              SizedBox(height: AppDimensions.extraLarge),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthSize * 0.15),
                child: MainButton(
                  onPressed: () {
                    authManager.onRegisterButtonPressed();
                  },
                  color: AppColors.secondaryBackgroundLogin,
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
      ),
    );
  }

  _displayDatePicker(BuildContext context, AuthManager authManager) async {
    final languageManager =
        Provider.of<LanguageManager>(context, listen: false);
    final String currentLocale = languageManager.getCurrentLocale(context);
    final LocaleType localeType = languageManager.getLocaleType(currentLocale);

    final selectedDate = await DatePicker.showDatePicker(context,
        locale: localeType, minTime: DateTime(1900));

    if (selectedDate != null) {
      authManager.onBirthdaySelected(selectedDate);
      _dateController.text = DateFormat.yMd(currentLocale).format(selectedDate);
    }
  }
}
