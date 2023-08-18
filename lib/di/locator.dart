import 'package:app_studiogenesis/navigation/main_navigation_handler.dart';
import 'package:app_studiogenesis/navigation/navigation_handler.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator
      .registerLazySingleton<NavigationHandler>(() => MainNavigationHandler());
}
