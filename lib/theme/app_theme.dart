import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF00FF41),
      scaffoldBackgroundColor: const Color(0xFF23272A),
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF00FF41),
        secondary: const Color(0xFF00FF41),
        background: const Color(0xFF23272A),
        surface: const Color(0xFF2C2F33),
      ),
      cardColor: const Color(0xFF2C2F33),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF23272A),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF00FF41)),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF00FF41)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF23272A),
        selectedItemColor: Color(0xFF00FF41),
        unselectedItemColor: Colors.white70,
      ),
    );
  }
} 