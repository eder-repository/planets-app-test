import 'package:flutter/material.dart';

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension TextThemeX on BuildContext {
  TextTheme get textTheme => theme.textTheme;
}

extension MediaQueryX on BuildContext {
  Size get planetsSize => MediaQuery.sizeOf(this);
  double get height => planetsSize.height;
  double get width => planetsSize.width;
}
