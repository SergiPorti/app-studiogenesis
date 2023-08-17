import 'package:app_studiogenesis/navigation/main_go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MainGoRouter _router = MainGoRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StudioGenesis',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      routerConfig: _router.router,
    );
  }
}
