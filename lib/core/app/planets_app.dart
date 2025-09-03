import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

class PlanetsApp extends ConsumerWidget {
  const PlanetsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Planets App Test',
      routeInformationParser: routerConfig.routeInformationParser,
      routerDelegate: routerConfig.routerDelegate,
      routeInformationProvider: routerConfig.routeInformationProvider,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
