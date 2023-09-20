import 'dart:io';

import 'package:app_studiogenesis/domain/models/user/user.dart';
import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/environment.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/language/language_manager.dart';
import 'package:app_studiogenesis/pages/widgets/appbar/app_bar_default.dart';
import 'package:app_studiogenesis/pages/widgets/input_text.dart';
import 'package:app_studiogenesis/pages/widgets/popup/default_popup.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SettingsUpdateUser extends StatelessWidget {
  SettingsUpdateUser({super.key});
  final TextEditingController _dateController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageManager>(
            create: (_) => LanguageManager()),
        ChangeNotifierProvider<AuthManager>(
            create: (_) => AuthManager(isLoginOrRegister: false))
      ],
      child: Consumer<AuthManager>(
        builder: (context, manager, child) {
          final User? user = manager.user;
          if (user != null) {
            _nameController.text = user.name;
            _lastNameController.text = user.lastName;
            _usernameController.text = user.username;
            _emailController.text = user.email;
            _dateController.text = _formatDate(context, user.birthDate);
          }
          return Scaffold(
            backgroundColor: AppColors.generalBackground,
            appBar: AppBarDefault(
                title: Text(
              S.of(context).personalSettings,
              style: TextStyle(
                  fontSize: AppDimensions.titleSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.extraLarge,
                  horizontal: AppDimensions.main),
              child: MainButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await manager.updateUserData().then((value) {
                    if (manager.currentState is ApiErrorState) {
                      final String message =
                          (manager.currentState as ApiErrorState).message;
                      final String? extensionMessage =
                          (manager.currentState as ApiErrorState).serverError;
                      final String descriptionMessage =
                          "$message \n $extensionMessage";
                      defaultPopupAsync(context,
                          title: S.of(context).somethingWentWrong,
                          description: descriptionMessage,
                          mainButtonText: S.of(context).goBack,
                          mainbuttonPressed: () => Navigator.pop(context));
                    } else {
                      defaultPopupAsync(context,
                          title: S.of(context).congratulations,
                          description: S.of(context).everithingWentWell,
                          mainButtonText: S.of(context).goBack,
                          mainbuttonPressed: () => Navigator.pop(context));
                    }
                  });
                },
                color: AppColors.secondaryBackgroundLogin,
                text: S.of(context).updateUser,
                expandWidth: true,
                textStyle: TextStyle(
                    fontSize: AppDimensions.main,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.extraLarge,
                    horizontal: AppDimensions.main),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => imagePopupPicker(context,
                          title: S.of(context).selectProfileImage,
                          galleryButtonText: S.of(context).gallery,
                          cameraButtontext: S.of(context).camera,
                          galleryButtonPressed: () async {
                        Navigator.pop(context);
                        await manager.pickImageFromGallery();
                      }, cameraButtonpressed: () async {
                        Navigator.pop(context);
                        await manager.pickImageFromCamera();
                      }),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.secondaryBackgroundLogin,
                                  width: 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: manager.image != null
                                  ? manager.isLocalFile
                                      ? Image.file(
                                          File(manager.image!.path),
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              '${Environment.ngrokImageUrl}${manager.image!.path}',
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )
                                  : Image.asset(
                                      'assets/img/user_placeholder.jpg',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(width: AppDimensions.large),
                          Text(
                            S.of(context).profileImage,
                            style: TextStyle(
                                fontSize: AppDimensions.large,
                                fontWeight: FontWeight.w600, ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: AppDimensions.large),
                    InputText(
                      label: S.of(context).name,
                      inputBackgroundColor: Colors.transparent,
                      inputBorderColor: AppColors.secondaryBackgroundLogin,
                      controller: _nameController,
                      errorText: manager.errorName
                          ? S.of(context).fieldCanNotBeEmpty
                          : null,
                      placeHolder: S.of(context).namePlaceholder,
                      onChangedText: (value) => manager.onNameChanged(value),
                    ),
                    SizedBox(height: AppDimensions.main),
                    InputText(
                      label: S.of(context).lastname,
                      inputBackgroundColor: Colors.transparent,
                      inputBorderColor: AppColors.secondaryBackgroundLogin,
                      placeHolder: S.of(context).lastnamePlaceholder,
                      controller: _lastNameController,
                      errorText: manager.errorLastname
                          ? S.of(context).fieldCanNotBeEmpty
                          : null,
                      onChangedText: (value) =>
                          manager.onLastNameChanged(value),
                    ),
                    SizedBox(height: AppDimensions.main),
                    InputText(
                      label: S.of(context).username,
                      inputBackgroundColor: Colors.transparent,
                      inputBorderColor: AppColors.secondaryBackgroundLogin,
                      controller: _usernameController,
                      placeHolder: S.of(context).usernameExample,
                      errorText: manager.errorUsername
                          ? S.of(context).fieldCanNotBeEmpty
                          : null,
                      onChangedText: (value) =>
                          manager.onUsernameChanged(value),
                    ),
                    SizedBox(height: AppDimensions.main),
                    InputText(
                      label: S.of(context).email,
                      inputBackgroundColor: Colors.transparent,
                      inputBorderColor: AppColors.secondaryBackgroundLogin,
                      placeHolder: S.of(context).emailPlaceholder,
                      controller: _emailController,
                      errorText:
                          manager.emailError ? S.of(context).emailError : null,
                      onChangedText: (value) => manager.onEmailChanged(value),
                    ),
                    SizedBox(
                      height: AppDimensions.main,
                    ),
                    InputText(
                      label: S.of(context).birthdate,
                      inputBackgroundColor: Colors.transparent,
                      inputBorderColor: AppColors.secondaryBackgroundLogin,
                      placeHolder: S.of(context).birthdatePlaceholder,
                      sufixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        size: 32,
                        color: Colors.white,
                      ),
                      errorText: manager.errorBirthdate
                          ? S.of(context).fieldCanNotBeEmpty
                          : null,
                      controller: _dateController,
                      readOnly: true,
                      onTap: () => _displayDatePicker(context, manager),
                    ),
                    SizedBox(
                      height: AppDimensions.large,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    final languageManager =
        Provider.of<LanguageManager>(context, listen: false);
    final String currentLocale = languageManager.getCurrentLocale(context);
    return DateFormat.yMd(currentLocale).format(date);
  }

  _displayDatePicker(BuildContext context, AuthManager manager) async {
    final languageManager =
        Provider.of<LanguageManager>(context, listen: false);
    final String currentLocale = languageManager.getCurrentLocale(context);
    final LocaleType localeType = languageManager.getLocaleType(currentLocale);

    final selectedDate = await DatePicker.showDatePicker(context,
        locale: localeType, minTime: DateTime(1900));

    if (selectedDate != null) {
      manager.onBirthdaySelected(selectedDate);
      _dateController.text = DateFormat.yMd(currentLocale).format(selectedDate);
    }
  }
}
