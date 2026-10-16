import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hawkar_app/core/localization/kurdish_strings.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/main.dart';

class OnboardingPageData {
  final IconData icon;
  final String badge;
  final String title;
  final String desc;
  final List<Color> gradient;
  final String heroTag;

  const OnboardingPageData({
    required this.icon,
    required this.badge,
    required this.title,
    required this.desc,
    required this.gradient,
    required this.heroTag,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const List<OnboardingPageData> _pages = [
    OnboardingPageData(
      icon: Icons.volunteer_activism_rounded,
      badge: "دەستپێکی هاوکاری کۆمەڵایەتی",
      title: KurdishStrings.onb1Title,
      desc: KurdishStrings.onb1Desc,
      gradient: [HawkarColors.primaryEmerald, HawkarColors.primaryMint],
      heroTag: "onb_hero_1",
    ),
    OnboardingPageData(
      icon: Icons.videocam_rounded,
      badge: "دەنگی خۆت بگەیەنە بە ڤیدیۆ",
      title: KurdishStrings.onb2Title,
      desc: KurdishStrings.onb2Desc,
      gradient: [HawkarColors.accentGold, HawkarColors.accentAmber],
      heroTag: "onb_hero_2",
    ),
    OnboardingPageData(
      icon: Icons.handshake_rounded,
      badge: "دەستی دەستگیرۆیی درێژ بکە",
      title: KurdishStrings.onb3Title,
      desc: KurdishStrings.onb3Desc,
      gradient: [HawkarColors.accentBlue, HawkarColors.primaryEmerald],
      heroTag: "onb_hero_3",
    ),
    OnboardingPageData(
      icon: Icons.verified_user_rounded,
      badge: "پارێزراو، متمانەپێکراو و بەڕێز",
      title: KurdishStrings.onb4Title,
      desc: KurdishStrings.onb4Desc,
      gradient: [HawkarColors.accentPurple, HawkarColors.primaryEmerald],
      heroTag: "onb_hero_4",
    ),
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
      body: Stack(
        children: [
          // Background ambient gradient orbs
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    HawkarColors.primaryEmerald.withOpacity(0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    HawkarColors.accentGold.withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top Header Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Hawkar Logo Chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: HawkarColors.surfaceGlass,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: HawkarColors.surfaceBorder),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: HawkarColors.primaryEmerald,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.handshake_rounded,
                                color: Colors.black,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              KurdishStrings.appName,
                              style: TextStyle(
                                color: HawkarColors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Skip Button
                      TextButton(
                        onPressed: _finishOnboarding,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          backgroundColor: Colors.white.withOpacity(0.04),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          KurdishStrings.skip,
                          style: TextStyle(
                            color: HawkarColors.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Page View
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      final page = _pages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 3D Glassmorphic Icon Showcase
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    page.gradient[0].withOpacity(0.3),
                                    page.gradient[1].withOpacity(0.05),
                                    Colors.transparent,
                                  ],
                                  radius: 0.95,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: HawkarColors.surfaceElevated,
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(
                                      color: page.gradient[0].withOpacity(0.65),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: page.gradient[0].withOpacity(0.3),
                                        blurRadius: 28,
                                        spreadRadius: 4,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      page.icon,
                                      size: 52,
                                      color: page.gradient[0],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),

                            // Badge Pill
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                              decoration: BoxDecoration(
                                color: page.gradient[0].withOpacity(0.12),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: page.gradient[0].withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                page.badge,
                                style: TextStyle(
                                  color: page.gradient[0],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Title
                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: HawkarColors.textPrimary,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                height: 1.35,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Description
                            Text(
                              page.desc,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: HawkarColors.textSecondary,
                                fontSize: 14.5,
                                height: 1.65,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Pagination & CTA Section
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
                            width: _currentPage == index ? 32 : 8,
                            height: 7,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? HawkarColors.primaryEmerald
                                  : HawkarColors.surfaceBorder,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: _currentPage == index
                                  ? [
                                      BoxShadow(
                                        color: HawkarColors.primaryEmerald.withOpacity(0.5),
                                        blurRadius: 8,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),

                      // Next / Get Started Action Button
                      Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: _currentPage == _pages.length - 1
                              ? HawkarColors.emeraldGradient
                              : HawkarColors.emeraldMintGradient,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: HawkarColors.primaryEmerald.withOpacity(0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage < _pages.length - 1) {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOutCubic,
                              );
                            } else {
                              _finishOnboarding();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentPage == _pages.length - 1
                                    ? KurdishStrings.getStarted
                                    : KurdishStrings.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.black,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
