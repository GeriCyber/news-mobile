import 'package:flutter/material.dart';

final myTheme = ThemeData.dark();
 
final appTheme = ThemeData(
  colorScheme: myTheme.colorScheme.copyWith(
    secondary: Colors.deepPurple,
  ),
);