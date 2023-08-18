import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TicketErrorWidget extends StatelessWidget {
  final String message;
  final String? extensionMessage;
  final Function onButtonPressed;
  const TicketErrorWidget(
      {required this.message,
      this.extensionMessage,
      required this.onButtonPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Padding(
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
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(height: AppDimensions.main),
          Text(
            message,
            style: TextStyle(
                fontSize: AppDimensions.main,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          SizedBox(height: AppDimensions.main),
          Text(
            extensionMessage ?? '',
            style: TextStyle(
                fontSize: AppDimensions.main,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
          SizedBox(height: AppDimensions.extraLarge),
          MainButton(
            text: S.of(context).goBack,
            expandWidth: true,
            onPressed: () => onButtonPressed.call(),
          )
        ],
      ),
    );
  }
}
