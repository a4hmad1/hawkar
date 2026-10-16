import 'package:flutter/material.dart';
import 'package:hawkar_app/core/localization/kurdish_strings.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      "icon": Icons.volunteer_activism,
      "badge": "دەستپێکی دەستگیرۆیی",
      "title": KurdishStrings.onb1Title,
      "desc": KurdishStrings.onb1Desc,
      "gradient": [HawkarColors.primaryEmerald, HawkarColors.primaryTeal],
    },
    {
      "icon": Icons.videocam_outlined,
      "badge": "دەنگی خۆت بگەیەنە",
      "title": KurdishStrings.onb2Title,
      "desc": KurdishStrings.onb2Desc,
      "gradient": [HawkarColors.accentGold, HawkarColors.accentAmber],
    },
    {
      "icon": Icons.handshake_outlined,
      "badge": "بەشداربە لە خێر",
      "title": KurdishStrings.onb3Title,
      "desc": KurdishStrings.onb3Desc,
      "gradient": [HawkarColors.accentBlue, HawkarColors.primaryEmerald],
    },
    {
      "icon": Icons.verified_user_outlined,
      "badge": "پارێزراو و متمانەپێکراو",
      "title": KurdishStrings.onb4Title,
      "desc": KurdishStrings.onb4Desc,
      "gradient": [HawkarColors.primaryEmerald, HawkarColors.surfaceElevated],
    },
  ];

  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MainNavigationShell(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HawkarColors.bgDark,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: HawkarColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: HawkarColors.surfaceBorder),
                        ),
                        child: const Icon(Icons.handshake, color: HawkarColors.primaryEmerald, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        KurdishStrings.appName,
                        style: TextStyle(
                          color: HawkarColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: const Text(
                      KurdishStrings.skip,
                      style: TextStyle(
                        color: HawkarColors.textMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page View
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Central Luxury Glowing Icon Frame
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                (page["gradient"][0] as Color).withOpacity(0.35),
                                Colors.transparent,
                              ],
                              radius: 0.9,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: HawkarColors.surfaceElevated,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: (page["gradient"][0] as Color).withOpacity(0.6),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: (page["gradient"][0] as Color).withOpacity(0.25),
                                    blurRadius: 24,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                page["icon"],
                                size: 44,
                                color: page["gradient"][0],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Badge Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: HawkarColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: HawkarColors.surfaceBorder),
                          ),
                          child: Text(
                            page["badge"],
                            style: TextStyle(
                              color: page["gradient"][0],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        Text(
                          page["title"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: HawkarColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Description
                        Text(
                          page["desc"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: HawkarColors.textSecondary,
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Indicators & Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  // Smooth Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? HawkarColors.primaryEmerald
                              : HawkarColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Main Button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _finishOnboarding();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? KurdishStrings.getStarted
                          : KurdishStrings.next,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
