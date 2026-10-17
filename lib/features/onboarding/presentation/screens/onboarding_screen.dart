import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hawkar_app/core/localization/kurdish_strings.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/main.dart';

class OnboardingPageData {
  final String badge;
  final String title;
  final String desc;
  final List<Color> gradient;
  final Widget heroWidget;

  const OnboardingPageData({
    required this.badge,
    required this.title,
    required this.desc,
    required this.gradient,
    required this.heroWidget,
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

  late final List<OnboardingPageData> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      // 1. Real Brand Logo
      OnboardingPageData(
        badge: "دەستپێکی هاوکاری کۆمەڵایەتی",
        title: KurdishStrings.onb1Title,
        desc: KurdishStrings.onb1Desc,
        gradient: [HawkarColors.primaryMint, HawkarColors.primaryEmerald],
        heroWidget: _buildLogoHeroCard(),
      ),
      // 2. Video Voice
      OnboardingPageData(
        badge: "دەنگی خۆت بگەیەنە بە ڤیدیۆ",
        title: KurdishStrings.onb2Title,
        desc: KurdishStrings.onb2Desc,
        gradient: [HawkarColors.accentGold, HawkarColors.accentAmber],
        heroWidget: _buildVideoHeroCard(),
      ),
      // 3. Helping Hands
      OnboardingPageData(
        badge: "دەستی دەستگیرۆیی درێژ بکە",
        title: KurdishStrings.onb3Title,
        desc: KurdishStrings.onb3Desc,
        gradient: [HawkarColors.primaryMint, HawkarColors.accentBlue],
        heroWidget: _buildCommunityHeroCard(),
      ),
      // 4. Trust & Safety
      OnboardingPageData(
        badge: "پارێزراو، متمانەپێکراو و بەڕێز",
        title: KurdishStrings.onb4Title,
        desc: KurdishStrings.onb4Desc,
        gradient: [HawkarColors.accentBlue, HawkarColors.primaryEmerald],
        heroWidget: _buildTrustHeroCard(),
      ),
    ];
  }

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

  // 1. Real Logo Hero Card
  Widget _buildLogoHeroCard() {
    return Container(
      width: 190,
      height: 190,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            HawkarColors.primaryMint.withOpacity(0.35),
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: HawkarColors.primaryMint.withOpacity(0.6),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: HawkarColors.primaryEmerald.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 4,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(33.5),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // 2. Video Storytelling Hero Card
  Widget _buildVideoHeroCard() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: HawkarColors.surfaceElevated,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: HawkarColors.accentAmber.withOpacity(0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: HawkarColors.accentAmber.withOpacity(0.3),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: HawkarColors.amberGoldGradient,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.videocam_rounded,
                size: 50,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: HawkarColors.accentRuby,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 3, backgroundColor: Colors.white),
                  SizedBox(width: 4),
                  Text("REC", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Collaborative Community Hero Card
  Widget _buildCommunityHeroCard() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: HawkarColors.surfaceElevated,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: HawkarColors.primaryMint.withOpacity(0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: HawkarColors.primaryEmerald.withOpacity(0.35),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: HawkarColors.brandGradient,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.handshake_rounded,
              size: 52,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // 4. Trust & Security Hero Card
  Widget _buildTrustHeroCard() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: HawkarColors.surfaceElevated,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: HawkarColors.accentBlue.withOpacity(0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: HawkarColors.accentBlue.withOpacity(0.3),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [HawkarColors.accentBlue, HawkarColors.primaryEmerald],
            ),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.verified_user_rounded,
              size: 52,
              color: Colors.black,
            ),
          ),
        ),
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
                      // Hawkar Official Logo & Title
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            KurdishStrings.appName,
                            style: TextStyle(
                              color: HawkarColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),

                      // Skip Button
                      TextButton(
                        onPressed: _finishOnboarding,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          backgroundColor: Colors.white.withOpacity(0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
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
                            // Rich Visual Hero Card
                            page.heroWidget,
                            const SizedBox(height: 36),

                            // Badge Pill
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                              decoration: BoxDecoration(
                                color: page.gradient[0].withOpacity(0.14),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: page.gradient[0].withOpacity(0.45),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                page.badge,
                                style: TextStyle(
                                  color: page.gradient[0],
                                  fontSize: 12.5,
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
                                  ? HawkarColors.primaryMint
                                  : HawkarColors.surfaceBorder,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: _currentPage == index
                                  ? [
                                      BoxShadow(
                                        color: HawkarColors.primaryMint.withOpacity(0.6),
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
                              ? HawkarColors.brandGradient
                              : HawkarColors.brandGradient,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: HawkarColors.primaryMint.withOpacity(0.4),
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
                          child: Text(
                            _currentPage == _pages.length - 1
                                ? KurdishStrings.getStarted
                                : KurdishStrings.next,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.5,
                              fontWeight: FontWeight.w900,
                            ),
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
