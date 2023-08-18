import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_studiogenesis/pages/settings/settings_page.dart';
import 'package:app_studiogenesis/pages/ticket/creation/create_ticket_page.dart';
import 'package:app_studiogenesis/pages/ticket/tickets_page.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final _pages = const <Widget>[
    TicketsPage(),
    CreateTicketPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.generalBackground,
        body: _getBody(),
        bottomNavigationBar: AnimatedBottomNavigationBar(
            activeColor: AppColors.secondaryBackgroundLogin,
            backgroundColor: AppColors.generalBackground,
            shadow: Shadow(
              blurRadius: 16,
              color: Colors.white.withOpacity(0.2),
            ),
            blurEffect: true,
            iconSize: 32,
            gapLocation: GapLocation.none,
            icons: const <IconData>[
              Icons.home_rounded,
              Icons.confirmation_num_rounded,
              Icons.settings_applications,
            ],
            activeIndex: index,
            onTap: (value) => setState(
                  () => index = value,
                )),
      ),
    );
  }

  Widget _getBody() {
    switch (index) {
      case 0:
        return _pages[0];
      case 1:
        return _pages[1];
      case 2:
        return _pages[2];
      default:
        return _pages[0];
    }
  }
}
