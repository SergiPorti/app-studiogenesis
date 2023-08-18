import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title; 
  const AppBarDefault({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(),
      backgroundColor: AppColors.generalCardBackground,
      shadowColor: Colors.white.withOpacity(0.3),
      iconTheme: const IconThemeData(color: Colors.white),
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
