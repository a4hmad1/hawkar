import 'dart:ui';
import 'package:flutter/material.dart';

class HawkarColors {
  // Base Obsidian, Titanium & Deep Slate
  static const Color bgDark = Color(0xFF080C14);
  static const Color surfaceDark = Color(0xFF101726);
  static const Color surfaceElevated = Color(0xFF192236);
  static const Color surfaceBorder = Color(0xFF23304B);
  static const Color surfaceGlass = Color(0x2E1E2B45);

  // Brand Accents
  static const Color primaryEmerald = Color(0xFF10B981);
  static const Color primaryMint = Color(0xFF34D399);
  static const Color primaryTeal = Color(0xFF0D9488);
  static const Color accentGold = Color(0xFFFBBF24);
  static const Color accentAmber = Color(0xFFF59E0B);
  static const Color accentRuby = Color(0xFFF43F5E);
  static const Color accentBlue = Color(0xFF38BDF8);
  static const Color accentPurple = Color(0xFFA855F7);

  // Typography
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textMuted = Color(0xFF64748B);

  // Gradients
  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldMintGradient = LinearGradient(
    colors: [Color(0xFF34D399), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient amberGoldGradient = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient rubySunsetGradient = LinearGradient(
    colors: [Color(0xFFF43F5E), Color(0xFFBE123C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient overlayGradient = LinearGradient(
    colors: [
      Colors.transparent,
      Color(0x55000000),
      Color(0xB3080C14),
      Color(0xF0080C14),
    ],
    stops: [0.25, 0.55, 0.8, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Box Shadows & Glows
  static List<BoxShadow> emeraldGlow = [
    BoxShadow(
      color: primaryEmerald.withOpacity(0.35),
      blurRadius: 16,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> goldGlow = [
    BoxShadow(
      color: accentGold.withOpacity(0.35),
      blurRadius: 16,
      spreadRadius: 2,
    ),
  ];
}

class HawkarTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: HawkarColors.bgDark,
      primaryColor: HawkarColors.primaryEmerald,
      cardColor: HawkarColors.surfaceDark,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: HawkarColors.bgDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: HawkarColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: HawkarColors.surfaceDark,
        selectedItemColor: HawkarColors.primaryEmerald,
        unselectedItemColor: HawkarColors.textMuted,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HawkarColors.primaryEmerald,
          foregroundColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
