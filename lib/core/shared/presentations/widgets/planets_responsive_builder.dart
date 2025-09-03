import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart' hide WidgetBuilder;

class PlanetsResponsiveBuilder extends StatelessWidget {
  const PlanetsResponsiveBuilder({
    required this.desktop,
    this.mobile,
    this.tablet,
    super.key,
  });
  final WidgetBuilder desktop;
  final WidgetBuilder? tablet;
  final WidgetBuilder? mobile;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      breakpoints: const ScreenBreakpoints(
        desktop: 912,
        tablet: 512,
        watch: 300,
      ),
      desktop: desktop,
      tablet: tablet,
      mobile: mobile,
    );
  }
}
