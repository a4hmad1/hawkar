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
  static const Color primaryEmerald = Color(0xFF659B28);
  static const Color primaryMint = Color(0xFF8DC63F);
  static const Color primaryTeal = Color(0xFF388E3C);
  static const Color accentGold = Color(0xFFF3E7C4);
  static const Color accentAmber = Color(0xFFD6C088);
  static const Color accentRuby = Color(0xFFF43F5E);
  static const Color accentBlue = Color(0xFF38BDF8);
  static const Color accentPurple = Color(0xFFA855F7);

  // Logo Brand Colors
  static const Color logoBgOlive = Color(0xFF24331C);
  static const Color logoLeafGreen = Color(0xFF72A832);
  static const Color logoChampagne = Color(0xFFF5EAC9);

  // Typography
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textMuted = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFF8DC63F), Color(0xFF558B2F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [Color(0xFF72A832), Color(0xFF436E1D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldMintGradient = LinearGradient(
    colors: [Color(0xFF8DC63F), Color(0xFF558B2F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient amberGoldGradient = LinearGradient(
    colors: [Color(0xFFF5EAC9), Color(0xFFD6C088)],
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
