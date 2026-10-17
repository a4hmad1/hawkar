import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/features/feed/data/datasources/mock_posts.dart';
import 'package:hawkar_app/features/feed/domain/models/assistance_post.dart';
import 'package:hawkar_app/features/feed/presentation/widgets/assistance_post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController _pageController = PageController();
  late List<AssistancePost> _posts;
  int _selectedTabIndex = 0; // 0: For You, 1: Nearby

  @override
  void initState() {
    super.initState();
    _posts = MockPostsDataSource.getSamplePosts();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HawkarColors.bgDark,
      body: Stack(
        children: [
          // 1. Vertical TikTok-style Feed
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              return AssistancePostCard(post: _posts[index]);
            },
          ),

          // 2. Top Navigation & Filters Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // App Brand Logo (Real Logo Image)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(0.15), width: 0.8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "هاوکار",
                              style: TextStyle(
                                color: HawkarColors.logoChampagne,
                                fontWeight: FontWeight.w900,
                                fontSize: 14.5,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Feed Toggle Tabs: For You vs Nearby
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(3.5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Colors.white.withOpacity(0.18), width: 0.8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _feedTab("بۆ تۆ", 0),
                            _feedTab("نزیک من", 1),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Search / Category Filter Button
                  GestureDetector(
                    onTap: () => _showFilterBottomSheet(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.18), width: 0.8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feedTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedTabIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? HawkarColors.primaryEmerald : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: HawkarColors.primaryEmerald.withOpacity(0.4),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: HawkarColors.surfaceDark.withOpacity(0.95),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "فلتەرکردنی پۆستەکان بەپێی جۆر",
                    style: TextStyle(
                      color: HawkarColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: [
                      _filterChip("هەموو هاوکارییەکان", true),
                      _filterChip("تەندروستی و دەرمان", false),
                      _filterChip("دارایی و بژێوی", false),
                      _filterChip("شارەزایی و پیشە", false),
                      _filterChip("فریاکەوتن و کتوپڕ", false),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: HawkarColors.emeraldGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: HawkarColors.primaryEmerald.withOpacity(0.35),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        "جێبەجێکردن",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _filterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8.5),
      decoration: BoxDecoration(
        color: isSelected ? HawkarColors.primaryEmerald : HawkarColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? HawkarColors.primaryEmerald : HawkarColors.surfaceBorder,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : HawkarColors.textSecondary,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
        ),
      ),
    );
  }
}
