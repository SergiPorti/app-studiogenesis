import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Consumer<AuthManager>(
      builder: (context, manager, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size * 0.15, horizontal: AppDimensions.main),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.xmain),
                  color: AppColors.lightBackground),
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.main),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimensions.xmain),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://media.giphy.com/media/qjgm2rlJ6wep88aitp/giphy.gif",
                        height: size * 0.25,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    SizedBox(height: AppDimensions.main),
                    Text(
                      (manager.currentState as ApiErrorState).message,
                      style: TextStyle(
                          fontSize: AppDimensions.main,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(height: AppDimensions.main),
                    Text(
                      (manager.currentState as ApiErrorState).serverError ?? '',
                      style: TextStyle(
                          fontSize: AppDimensions.main,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppDimensions.extraLarge,
                horizontal: AppDimensions.main),
            child: MainButton(
              text: S.of(context).backToLoginPage,
              expandWidth: true,
              onPressed: () => manager.changeErrorPageStateToAnonymous(),
            ),
          ),
        );
      },
    );
  }
}
