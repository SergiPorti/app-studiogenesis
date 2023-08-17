import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final bool expandWidth;
  final Color? color;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  const MainButton(
      {super.key,
      required this.text,
      this.expandWidth = false,
      this.color,
      this.textStyle,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed?.call(),
      style: ElevatedButton.styleFrom(
        minimumSize: expandWidth ? const Size.fromHeight(44) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: color ?? AppColors.secondaryBackgroundLogin,
      ),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
                fontSize: AppDimensions.main,
                fontWeight: FontWeight.w400,
                color: Colors.white),
      ),
    );
  }
}
