import 'package:flutter/material.dart';

class ColorPalette {
  final String name;
  final ColorScheme lightColorScheme;
  final ColorScheme darkColorScheme;

  const ColorPalette(this.name, this.lightColorScheme, this.darkColorScheme);
}

class AppColors {
  AppColors._();

  static const primary = Color(0xFF0F23D0);
  static const secondary = Color(0xFF640FD0);
  static const error = Color(0xFFD32F2F);
  static const success = Color(0xFF2E7D32);
  static const warning = Color(0xFFED6C02);
  static const info = Color(0xFF01579B);
  static final divider = Colors.black.withOpacity(0.12);
  static final iconColor = Colors.black.withOpacity(0.54);
  static final outline = Colors.black.withOpacity(0.23);
  static final textColor = Colors.black.withOpacity(0.87);
  static final secondaryTextColor = Colors.black.withOpacity(0.6);
}
