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
      // Kurdish Sorani RTL Directionality & Localization
      locale: const Locale('ckb', 'IQ'), // Central Kurdish / Sorani
      supportedLocales: const [
        Locale('ckb', 'IQ'),
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
    SizedBox.shrink(), // Placeholder for center post button
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
        decoration: const BoxDecoration(
          color: HawkarColors.surfaceDark,
          border: Border(
            top: BorderSide(color: HawkarColors.surfaceBorder, width: 0.8),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onBottomNavTapped,
          backgroundColor: HawkarColors.surfaceDark,
          selectedItemColor: HawkarColors.primaryEmerald,
          unselectedItemColor: HawkarColors.textMuted,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "ڕووبەر",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: "گەڕان",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  gradient: HawkarColors.emeraldGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: HawkarColors.primaryEmerald.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.black, size: 20),
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.handshake_outlined),
              label: "هاوکارییەکان",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "هەژمار",
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
      appBar: AppBar(title: const Text("گەڕان بەپێی شار و جۆر")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 64, color: HawkarColors.primaryEmerald.withOpacity(0.6)),
            const SizedBox(height: 16),
            const Text(
              "نەخشەی هاوکاری لە کوردستان",
              style: TextStyle(color: HawkarColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "هەولێر • سلێمانی • دهۆک • کەرکووک • هەڵەبجە",
              style: TextStyle(color: HawkarColors.textMuted, fontSize: 14),
            ),
          ],
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
      appBar: AppBar(title: const Text("چالاکی و بەشداریکردنەکانم")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.volunteer_activism_outlined, size: 64, color: HawkarColors.accentGold.withOpacity(0.6)),
            const SizedBox(height: 16),
            const Text(
              "تۆ هێشتا دەستگیرۆیی هیچ کەسێکت تۆمار نەکردووە",
              style: TextStyle(color: HawkarColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "سەیری ڕووبەری ڤیدیۆکان بکە و دەستێک بەخشندە بە",
              style: TextStyle(color: HawkarColors.textMuted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
