import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app_test/features/features.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const SplashScreen._();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: BodyWidget(),
    );
  }
}
