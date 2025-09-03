import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/i18n/translations.g.dart';

Future<void> bootstrap(Environments env) async {
  final enableLogging = env.enableLogging;
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await LocaleSettings.useDeviceLocale();

      // final appDir = switch (kIsWeb) {
      //   true => Directory('local-storage'),
      //   false => await getApplicationSupportDirectory(),
      // };

      // final localStorage = LocalStorage(
      //   enableLogging: enableLogging,
      //   dbPath: join(appDir.path, 'planets.db'),
      // );

      GoRouter.optionURLReflectsImperativeAPIs = true;
      final planets = TranslationProvider(
        child: ProviderScope(
          overrides: [
            Providers.env.overrideWithValue(env),
            // Providers.localStorage.overrideWithValue(localStorage),
          ],
          child: const PlanetsApp(),
        ),
      );
      runApp(planets);
      FlutterError.onError = (details) {
        if (enableLogging) {
          log(details.exceptionAsString(), stackTrace: details.stack);
        }
      };
    },
    (error, stack) {
      if (enableLogging) {
        log(error.toString(), stackTrace: stack);
      }
    },
  );
}
