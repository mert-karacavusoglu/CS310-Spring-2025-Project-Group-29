import 'package:flutter/material.dart';

class appcolor {
  static const Color primary = Colors.white;
  static const Color secondary = Color(0xFF070000);
  static const Color backgroundColor = Color(0xFF18D618);
  static const double regular = 8.0;
  static const double extra = 16.0;
  final TextStyle appbarStyle = TextStyle(
    color: backgroundColor,
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
  );
  static get regularPadding => const EdgeInsets.all(regular);
  static get extraPadding => const EdgeInsets.all(extra);
}