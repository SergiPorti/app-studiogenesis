import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class SettingsContainerOption extends StatelessWidget {
  final Widget icon;
  final Function onContainerPressed;
  final BoxDecoration boxDecoration;
  final String title;
  final String subtitle;
  const SettingsContainerOption(
      {super.key,
      required this.icon,
      required this.onContainerPressed,
      required this.boxDecoration,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onContainerPressed.call(),
      child: Container(
        decoration: boxDecoration,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.main),
          child: Row(
            children: [
              Flexible(flex: 3, fit: FlexFit.tight, child: icon),
              const Spacer(),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontSize: AppDimensions.titleSize,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      SizedBox(height: AppDimensions.small),
                      Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: AppDimensions.label,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )
                    ],
                  )),
              const Spacer(),
              const Flexible(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
