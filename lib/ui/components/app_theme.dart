import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  const primaryColor = Color.fromRGBO(197, 53, 50, 1);
  const primaryColorLight = Color.fromRGBO(209, 99, 111, 1);
  const contrastColor = Color.fromRGBO(231, 231, 231, 1);

  return ThemeData(
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, background: contrastColor),
    useMaterial3: true,
  );
}
