import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:flutter/material.dart';

Widget defaultPopup(BuildContext context,
    {required String title,
    required String description,
    required String mainButtonText,
    required Function() mainbuttonPressed}) {
  return AlertDialog(
    insetPadding: EdgeInsets.all(AppDimensions.main),
    title: Text(
      title,
      style: TextStyle(
          fontSize: AppDimensions.large,
          fontWeight: FontWeight.w700,
          color: Colors.white),
    ),
    content: Text(
      description,
      style: TextStyle(
          fontSize: AppDimensions.main,
          fontWeight: FontWeight.w400,
          color: Colors.white),
    ),
    actions: [
      MainButton(
        text: mainButtonText,
        expandWidth: true,
        onPressed: () => mainbuttonPressed.call(),
      )
    ],
  );
}

Future<T?> defaultPopupAsync<T>(BuildContext context,
    {required String title,
    required String description,
    required String mainButtonText,
    required T Function() mainbuttonPressed}) async {
  return await showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(AppDimensions.main),
        title: Text(
          title,
          style: TextStyle(
              fontSize: AppDimensions.large,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        content: Text(
          description,
          style: TextStyle(
              fontSize: AppDimensions.main,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
        actions: [
          MainButton(
            text: mainButtonText,
            expandWidth: true,
            onPressed: () => mainbuttonPressed.call(),
          )
        ],
      );
    },
  );
}

Future<T?> imagePopupPicker<T>(BuildContext context,
    {required String title,
    required String galleryButtonText,
    required String cameraButtontext,
    required T Function() galleryButtonPressed,
    required T Function() cameraButtonpressed}) async {
  return await showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(AppDimensions.main),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: AppDimensions.large,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SizedBox(width: AppDimensions.small),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close_rounded,
                  size: 32,
                ))
          ],
        ),
        actions: [
          MainButton(
            text: galleryButtonText,
            expandWidth: true,
            onPressed: () => galleryButtonPressed.call(),
          ),
          SizedBox(height: AppDimensions.xmain),
          MainButton(
              text: cameraButtontext,
              expandWidth: true,
              onPressed: () => cameraButtonpressed.call()),
        ],
      );
    },
  );
}
