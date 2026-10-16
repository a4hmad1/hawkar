import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/features/feed/domain/models/assistance_post.dart';
import 'package:hawkar_app/features/feed/presentation/widgets/assistance_details_sheet.dart';

class AssistancePostCard extends StatefulWidget {
  final AssistancePost post;

  const AssistancePostCard({
    super.key,
    required this.post,
  });

  @override
  State<AssistancePostCard> createState() => _AssistancePostCardState();
}

class _AssistancePostCardState extends State<AssistancePostCard>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late int _likeCount;
  bool _isSaved = false;
  late int _helperCount;
  bool _hasOfferedHelp = false;
  bool _isDescriptionExpanded = false;

  // Double-tap heart animation
  bool _showHeartAnimation = false;
  Offset _heartTapPosition = Offset.zero;

  // Rotating audio disc animation
  late AnimationController _discController;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.respectCount;
    _helperCount = widget.post.helperCount;

    _discController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _discController.dispose();
    super.dispose();
  }

  void _triggerDoubleTapHeart(TapDownDetails details) {
    setState(() {
      _heartTapPosition = details.localPosition;
      _showHeartAnimation = true;
      if (!_isLiked) {
        _isLiked = true;
        _likeCount += 1;
      }
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() => _showHeartAnimation = false);
      }
    });
  }

  void _toggleHelpOffer() {
    setState(() {
      _hasOfferedHelp = !_hasOfferedHelp;
      _helperCount += _hasOfferedHelp ? 1 : -1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: HawkarColors.surfaceElevated,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Row(
          children: [
            Icon(
              _hasOfferedHelp ? Icons.check_circle_rounded : Icons.info_outline_rounded,
              color: _hasOfferedHelp ? HawkarColors.primaryEmerald : HawkarColors.textMuted,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _hasOfferedHelp
                    ? "دەستخۆش! ئامادەییت بۆ هاوکاری بە سەرکەوتوویی تۆمارکرا."
                    : "هاوکارییەکەت هەڵوەشێنرایەوە.",
                style: const TextStyle(
                  color: HawkarColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetailsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AssistanceDetailsSheet(
        post: widget.post,
        onHelpOffered: _toggleHelpOffer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onDoubleTapDown: _triggerDoubleTapHeart,
      onDoubleTap: () {},
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Procedural Luxury Art Backdrop (Always Beautiful Even Offline)
          _buildProceduralBackdrop(),

          // 2. Network Media (Fades in over backdrop if online)
          Image.network(
            widget.post.mediaUrl,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) {
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: child,
                );
              }
              return const SizedBox.shrink();
            },
            errorBuilder: (context, error, stackTrace) {
              // Keeps the luxury procedural canvas
              return const SizedBox.shrink();
            },
          ),

          // 3. Cinematic Vignette Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: HawkarColors.overlayGradient,
            ),
          ),

          // 4. Subtle Top Shade for Status Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 110,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x99000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // 5. TikTok Right-Side Action Rail
          Positioned(
            right: 12,
            bottom: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Author Avatar with '+' Badge
                _buildAuthorAvatar(),
                const SizedBox(height: 20),

                // Heart / Respect
                _buildActionIcon(
                  icon: _isLiked ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                  iconColor: _isLiked ? HawkarColors.accentRuby : Colors.white,
                  label: "$_likeCount",
                  onTap: () {
                    setState(() {
                      _isLiked = !_isLiked;
                      _likeCount += _isLiked ? 1 : -1;
                    });
                  },
                ),
                const SizedBox(height: 18),

                // Comments
                _buildActionIcon(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: "${widget.post.commentCount}",
                  onTap: _openDetailsSheet,
                ),
                const SizedBox(height: 18),

                // Save / Bookmark
                _buildActionIcon(
                  icon: _isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  iconColor: _isSaved ? HawkarColors.accentGold : Colors.white,
                  label: "پاشەکەوت",
                  onTap: () {
                    setState(() => _isSaved = !_isSaved);
                  },
                ),
                const SizedBox(height: 18),

                // Share
                _buildActionIcon(
                  icon: Icons.share_rounded,
                  label: "هاوبەشکردن",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("بەستەری ئەم پۆستە لەبەرگیرایەوە!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 22),

                // TikTok Rotating Hope/Vinyl Disc
                _buildRotatingDisc(),
              ],
            ),
          ),

          // 6. Bottom Information & Call to Action Overlay
          Positioned(
            left: 16,
            right: 84, // Space for right action rail
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Category & Urgency Badges
                Row(
                  children: [
                    _buildTypeBadge(),
                    const SizedBox(width: 8),
                    _buildCategoryBadge(),
                    if (widget.post.isUrgent) ...[
                      const SizedBox(width: 8),
                      _buildUrgentBadge(),
                    ],
                  ],
                ),
                const SizedBox(height: 12),

                // Author Name & Verified ID
                Row(
                  children: [
                    Text(
                      widget.post.author.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(color: Colors.black54, blurRadius: 6),
                        ],
                      ),
                    ),
                    if (widget.post.author.isVerified) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.verified_rounded,
                        color: HawkarColors.accentBlue,
                        size: 17,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),

                // Post Title
                Text(
                  widget.post.title,
                  style: const TextStyle(
                    color: HawkarColors.textPrimary,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                    shadows: [
                      Shadow(color: Colors.black87, blurRadius: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                // Post Description (Expandable)
                GestureDetector(
                  onTap: () {
                    setState(() => _isDescriptionExpanded = !_isDescriptionExpanded);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.description,
                        maxLines: _isDescriptionExpanded ? 8 : 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xEEFFFFFF),
                          fontSize: 13,
                          height: 1.45,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 6),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _isDescriptionExpanded ? "کەمتر ببینە" : "...زیاتر ببینە",
                        style: const TextStyle(
                          color: HawkarColors.accentGold,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Budget & Location Tag
                Row(
                  children: [
                    if (!widget.post.isFree && widget.post.amount != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: HawkarColors.accentAmber.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: HawkarColors.accentAmber.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.payments_rounded,
                              color: HawkarColors.accentGold,
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.post.formattedBudget,
                              style: const TextStyle(
                                color: HawkarColors.accentGold,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24, width: 0.8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: HawkarColors.primaryEmerald,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.post.locationCity,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Primary "دەتوانم یارمەتی بدەم" Button
                _buildMainHelpButton(),
              ],
            ),
          ),

          // 7. Double-Tap Floating Heart Burst Animation
          if (_showHeartAnimation)
            Positioned(
              left: _heartTapPosition.dx - 45,
              top: _heartTapPosition.dy - 45,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.2, end: 1.3),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: HawkarColors.accentRuby.withOpacity(0.6),
                            blurRadius: 28,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: HawkarColors.accentRuby,
                        size: 90,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // Resilient Procedural Backdrop when offline or loading
  Widget _buildProceduralBackdrop() {
    List<Color> gradientColors;
    IconData categoryIcon;

    switch (widget.post.category) {
      case AssistanceCategory.medical:
        gradientColors = [const Color(0xFF2E0814), const Color(0xFF130914), const Color(0xFF080C14)];
        categoryIcon = Icons.medical_services_rounded;
        break;
      case AssistanceCategory.financial:
        gradientColors = [const Color(0xFF2C1B03), const Color(0xFF1A1308), const Color(0xFF080C14)];
        categoryIcon = Icons.volunteer_activism_rounded;
        break;
      case AssistanceCategory.education:
        gradientColors = [const Color(0xFF06202A), const Color(0xFF0A1826), const Color(0xFF080C14)];
        categoryIcon = Icons.school_rounded;
        break;
      case AssistanceCategory.dailyHelp:
      default:
        gradientColors = [const Color(0xFF06281D), const Color(0xFF0B1B1C), const Color(0xFF080C14)];
        categoryIcon = Icons.handshake_rounded;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
              ),
              child: Center(
                child: Icon(
                  categoryIcon,
                  size: 54,
                  color: HawkarColors.primaryEmerald.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.post.categoryNameKurdish,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorAvatar() {
    final isRequest = widget.post.type == AssistanceType.request;

    return GestureDetector(
      onTap: _openDetailsSheet,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isRequest
                  ? HawkarColors.amberGoldGradient
                  : HawkarColors.emeraldGradient,
              boxShadow: [
                BoxShadow(
                  color: (isRequest ? HawkarColors.accentGold : HawkarColors.primaryEmerald)
                      .withOpacity(0.35),
                  blurRadius: 10,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 23,
              backgroundColor: HawkarColors.surfaceElevated,
              backgroundImage: widget.post.author.avatarUrl != null
                  ? NetworkImage(widget.post.author.avatarUrl!)
                  : null,
              child: widget.post.author.avatarUrl == null
                  ? const Icon(Icons.shield_rounded, color: HawkarColors.primaryEmerald, size: 24)
                  : null,
            ),
          ),
          Positioned(
            bottom: -7,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: HawkarColors.primaryEmerald,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_rounded, size: 13, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required String label,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Icon(icon, color: iconColor, size: 25),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              shadows: [Shadow(color: Colors.black87, blurRadius: 4)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRotatingDisc() {
    return RotationTransition(
      turns: _discController,
      child: Container(
        width: 44,
        height: 44,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [Color(0xFF262626), Color(0xFF0F0F0F)],
          ),
          border: Border.all(color: Colors.white24, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: HawkarColors.primaryEmerald,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeBadge() {
    final isRequest = widget.post.type == AssistanceType.request;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
      decoration: BoxDecoration(
        gradient: isRequest ? HawkarColors.amberGoldGradient : HawkarColors.emeraldGradient,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: (isRequest ? HawkarColors.accentGold : HawkarColors.primaryEmerald)
                .withOpacity(0.45),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        isRequest ? "داواکاری" : "پێشکەشکردن",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 0.8),
      ),
      child: Text(
        widget.post.categoryNameKurdish,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildUrgentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: HawkarColors.rubySunsetGradient,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: HawkarColors.accentRuby.withOpacity(0.5),
            blurRadius: 8,
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_rounded, color: Colors.white, size: 13),
          SizedBox(width: 2),
          Text(
            "بەپەلە",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainHelpButton() {
    final isRequest = widget.post.type == AssistanceType.request;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasOfferedHelp
            ? null
            : (isRequest ? HawkarColors.emeraldGradient : HawkarColors.amberGoldGradient),
        color: _hasOfferedHelp ? HawkarColors.surfaceElevated : null,
        borderRadius: BorderRadius.circular(16),
        border: _hasOfferedHelp
            ? Border.all(color: HawkarColors.primaryEmerald, width: 1.5)
            : null,
        boxShadow: _hasOfferedHelp
            ? null
            : [
                BoxShadow(
                  color: (isRequest ? HawkarColors.primaryEmerald : HawkarColors.accentGold)
                      .withOpacity(0.4),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: _openDetailsSheet,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _hasOfferedHelp
                  ? Icons.check_circle_rounded
                  : (isRequest ? Icons.volunteer_activism_rounded : Icons.handshake_rounded),
              color: _hasOfferedHelp ? HawkarColors.primaryEmerald : Colors.black,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              _hasOfferedHelp
                  ? "ئامادەییت تۆمارکرا ($_helperCount)"
                  : (isRequest
                      ? "دەتوانم یارمەتی بدەم ($_helperCount)"
                      : "داواکردنی ئەم هاوکارییە"),
              style: TextStyle(
                color: _hasOfferedHelp ? HawkarColors.primaryEmerald : Colors.black,
                fontSize: 13.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
