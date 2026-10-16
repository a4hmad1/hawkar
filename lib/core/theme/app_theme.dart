import 'package:flutter/material.dart';

class HawkarColors {
  // Base Obsidian & Deep Slate
  static const Color bgDark = Color(0xFF090D16);
  static const Color surfaceDark = Color(0xFF131A29);
  static const Color surfaceElevated = Color(0xFF1C2538);
  static const Color surfaceBorder = Color(0xFF28354D);

  // Brand Accents
  static const Color primaryEmerald = Color(0xFF10B981);
  static const Color primaryTeal = Color(0xFF14B8A6);
  static const Color accentGold = Color(0xFFFBBF24);
  static const Color accentAmber = Color(0xFFF59E0B);
  static const Color accentRuby = Color(0xFFEF4444);
  static const Color accentBlue = Color(0xFF38BDF8);

  // Typography
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Gradients
  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient amberGradient = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient overlayGradient = LinearGradient(
    colors: [
      Colors.transparent,
      Colors.black38,
      Colors.black87,
      Colors.black,
    ],
    stops: [0.3, 0.55, 0.8, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
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
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HawkarColors.primaryEmerald,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
