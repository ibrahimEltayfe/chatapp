import 'package:chatapp/app_routers.dart';
import 'package:chatapp/core/constants/app_routes.dart';
import 'package:chatapp/initialize_app_services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'l10n/app_localizations.dart';

void main() async {
  final container = ProviderContainer();
  await container.read(initializeAppServicesProvider).init();

  runApp(UncontrolledProviderScope(
    container: container,
    child: DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          child!,

          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(350, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],

          breakpointsLandscape: [
            const ResponsiveBreakpoint.resize(560, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(812, name: MOBILE),
            const ResponsiveBreakpoint.resize(1024, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1120, name: TABLET),
          ],
        );
      },

      onGenerateRoute: RoutesManager.routes,
      initialRoute: AppRoutes.decide,
      
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: localeCallBack,
    );
  }
}

Locale localeCallBack(Locale? locale,Iterable<Locale> supportedLocales){
  
    if (locale == null) {
      return supportedLocales.first;
    }

    for (var supportedLocale in supportedLocales) {
      if (locale.countryCode == supportedLocale.countryCode) {
        return supportedLocale;
      }
    }

    return locale;
}

