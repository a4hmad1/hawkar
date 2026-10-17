
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/features/auth/presentation/screens/auth_profile_screen.dart';
import 'package:hawkar_app/features/feed/presentation/screens/feed_screen.dart';
import 'package:hawkar_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:hawkar_app/features/post_creation/presentation/screens/create_post_screen.dart';

void main() {
  runApp(const HawkarApp());
}

class HawkarApp extends StatelessWidget {
  const HawkarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هاوکار - پلاتفۆرمی هاوکاری کۆمەڵایەتی',
      debugShowCheckedModeBanner: false,
      theme: HawkarTheme.darkTheme,
      // Native Kurdish RTL Directionality & Localization
      locale: const Locale('ar', 'IQ'),
      supportedLocales: const [
        Locale('ar', 'IQ'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // Native RTL Kurdish
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const OnboardingScreen(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    FeedScreen(),
    _ExplorePlaceholder(),
    SizedBox.shrink(), // Center trigger
    _ActivityPlaceholder(),
    AuthProfileScreen(),
  ];

  void _onBottomNavTapped(int index) {
    if (index == 2) {
      // Open Create Post modal screen
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const CreatePostScreen(),
        ),
      );
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HawkarColors.bgDark,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: HawkarColors.surfaceDark.withOpacity(0.96),
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.08), width: 0.8),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(0, Icons.home_rounded, Icons.home_outlined, "ڕووبەر"),
                _navItem(1, Icons.explore_rounded, Icons.explore_outlined, "گەڕان"),
                _centerCreateButton(),
                _navItem(3, Icons.handshake_rounded, Icons.handshake_outlined, "هاوکارییەکان"),
                _navItem(4, Icons.person_rounded, Icons.person_outline_rounded, "هەژمار"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _centerCreateButton() {
    return GestureDetector(
      onTap: () => _onBottomNavTapped(2),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: HawkarColors.brandGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: HawkarColors.primaryMint.withOpacity(0.45),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.add_rounded,
            color: Colors.black,
            size: 26,
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onBottomNavTapped(index),
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected ? HawkarColors.primaryMint : HawkarColors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? HawkarColors.primaryMint : HawkarColors.textMuted,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplorePlaceholder extends StatelessWidget {
  const _ExplorePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HawkarColors.bgDark,
      appBar: AppBar(
        title: const Text("گەڕان بەپێی شار و جۆر"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: HawkarColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: HawkarColors.surfaceBorder),
                ),
                child: const Center(
                  child: Icon(
                    Icons.map_rounded,
                    size: 44,
                    color: HawkarColors.primaryEmerald,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "نەخشەی دەستگیری و هاوکاری لە کوردستان",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HawkarColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "هەولێر • سلێمانی • دهۆک • کەرکووک • هەڵەبجە • زاخۆ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HawkarColors.textSecondary,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityPlaceholder extends StatelessWidget {
  const _ActivityPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HawkarColors.bgDark,
      appBar: AppBar(
        title: const Text("چالاکی و بەشداریکردنەکانم"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: HawkarColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: HawkarColors.surfaceBorder),
                ),
                child: const Center(
                  child: Icon(
                    Icons.volunteer_activism_rounded,
                    size: 44,
                    color: HawkarColors.accentGold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "تۆ هێشتا دەستگیرۆیی هیچ داواکارییەکت نەکردووە",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HawkarColors.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "سەیری ڕووبەری ڤیدیۆکان بکە و دەستێکی خێر و بەخشندە بە بۆ هاوڵاتییانی کوردستان",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HawkarColors.textSecondary,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
