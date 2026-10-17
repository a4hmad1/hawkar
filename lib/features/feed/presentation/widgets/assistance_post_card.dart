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

class _AssistancePostCardState extends State<AssistancePostCard> {
  bool _isLiked = false;
  late int _likeCount;
  bool _isSaved = false;
  late int _helperCount;
  bool _hasOfferedHelp = false;
  bool _isDescriptionExpanded = false;

  // Double-tap heart animation
  bool _showHeartAnimation = false;
  Offset _heartTapPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.respectCount;
    _helperCount = widget.post.helperCount;
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

    Future.delayed(const Duration(milliseconds: 800), () {
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
              color: _hasOfferedHelp ? HawkarColors.primaryMint : HawkarColors.textMuted,
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
    return GestureDetector(
      onDoubleTapDown: _triggerDoubleTapHeart,
      onDoubleTap: () {},
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Procedural Backdrop (Always visible, beautiful even offline)
          _buildProceduralBackdrop(),

          // 2. Network Image (Fades in over backdrop)
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
            errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
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
            height: 120,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x88000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // 5. Right-Side Action Rail (TikTok Style)
          Positioned(
            right: 12,
            bottom: 86,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Author Avatar
                _buildAuthorAvatar(),
                const SizedBox(height: 18),

                // Heart / Like
                _buildActionIcon(
                  icon: _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  iconColor: _isLiked ? HawkarColors.accentRuby : Colors.white,
                  label: "$_likeCount",
                  onTap: () {
                    setState(() {
                      _isLiked = !_isLiked;
                      _likeCount += _isLiked ? 1 : -1;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Comments
                _buildActionIcon(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: "${widget.post.commentCount}",
                  onTap: _openDetailsSheet,
                ),
                const SizedBox(height: 16),

                // Save / Bookmark
                _buildActionIcon(
                  icon: _isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  iconColor: _isSaved ? HawkarColors.accentGold : Colors.white,
                  label: "پاشەکەوت",
                  onTap: () {
                    setState(() => _isSaved = !_isSaved);
                  },
                ),
                const SizedBox(height: 16),

                // Share
                _buildActionIcon(
                  icon: Icons.share_rounded,
                  label: "ناردن",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("بەستەری پۆست لەبەرگیرایەوە!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // 6. Bottom Information Card Overlay
          Positioned(
            left: 14,
            right: 76, // Generous breathing room before the right action rail
            bottom: 74,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Category & Urgency Badges
                Row(
                  children: [
                    _buildTypeAndCategoryBadge(),
                    if (widget.post.isUrgent) ...[
                      const SizedBox(width: 6),
                      _buildUrgentBadge(),
                    ],
                  ],
                ),
                const SizedBox(height: 8),

                // Author Name & Location
                Row(
                  children: [
                    Text(
                      widget.post.author.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(color: Colors.black87, blurRadius: 6),
                        ],
                      ),
                    ),
                    if (widget.post.author.isVerified) ...[
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.verified_rounded,
                        color: HawkarColors.accentBlue,
                        size: 16,
                      ),
                    ],
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on_rounded, color: HawkarColors.primaryMint, size: 12),
                          const SizedBox(width: 3),
                          Text(
                            widget.post.locationCity,
                            style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Post Title
                Text(
                  widget.post.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                    shadows: [
                      Shadow(color: Colors.black87, blurRadius: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 5),

                // Post Description (Expandable)
                GestureDetector(
                  onTap: () {
                    setState(() => _isDescriptionExpanded = !_isDescriptionExpanded);
                  },
                  child: Text(
                    widget.post.description,
                    maxLines: _isDescriptionExpanded ? 8 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12.5,
                      height: 1.4,
                      shadows: const [
                        Shadow(color: Colors.black87, blurRadius: 6),
                      ],
                    ),
                  ),
                ),

                // Budget if available
                if (!widget.post.isFree && widget.post.amount != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: HawkarColors.logoChampagne.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: HawkarColors.logoChampagne.withOpacity(0.4), width: 0.8),
                    ),
                    child: Text(
                      widget.post.formattedBudget,
                      style: const TextStyle(
                        color: HawkarColors.logoChampagne,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // 7. Full-Width Primary CTA Button (Sits Elegantly Above Bottom Nav Bar)
          Positioned(
            left: 14,
            right: 14,
            bottom: 12,
            child: _buildMainHelpButton(),
          ),

          // 8. Double-Tap Floating Heart Burst Animation
          if (_showHeartAnimation)
            Positioned(
              left: _heartTapPosition.dx - 45,
              top: _heartTapPosition.dy - 45,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.3, end: 1.25),
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
                            blurRadius: 30,
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

  // Procedural Backdrop for Slow/Offline Media
  Widget _buildProceduralBackdrop() {
    List<Color> gradientColors;
    IconData categoryIcon;

    switch (widget.post.category) {
      case AssistanceCategory.medical:
        gradientColors = [const Color(0xFF260D13), const Color(0xFF160910), HawkarColors.bgDark];
        categoryIcon = Icons.medical_services_rounded;
        break;
      case AssistanceCategory.financial:
        gradientColors = [const Color(0xFF28200C), const Color(0xFF161208), HawkarColors.bgDark];
        categoryIcon = Icons.volunteer_activism_rounded;
        break;
      case AssistanceCategory.education:
        gradientColors = [const Color(0xFF0D2128), const Color(0xFF09161B), HawkarColors.bgDark];
        categoryIcon = Icons.school_rounded;
        break;
      case AssistanceCategory.dailyHelp:
      default:
        gradientColors = [HawkarColors.logoBgOlive, const Color(0xFF121B0F), HawkarColors.bgDark];
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
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
          ),
          child: Center(
            child: Icon(
              categoryIcon,
              size: 46,
              color: HawkarColors.primaryMint.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorAvatar() {
    return GestureDetector(
      onTap: _openDetailsSheet,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: HawkarColors.brandGradient,
              boxShadow: [
                BoxShadow(
                  color: HawkarColors.primaryMint.withOpacity(0.35),
                  blurRadius: 8,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: HawkarColors.surfaceElevated,
              backgroundImage: widget.post.author.avatarUrl != null
                  ? NetworkImage(widget.post.author.avatarUrl!)
                  : null,
              child: widget.post.author.avatarUrl == null
                  ? const Icon(Icons.shield_rounded, color: HawkarColors.primaryMint, size: 22)
                  : null,
            ),
          ),
          Positioned(
            bottom: -6,
            child: Container(
              padding: const EdgeInsets.all(2.5),
              decoration: const BoxDecoration(
                color: HawkarColors.primaryMint,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_rounded, size: 12, color: Colors.black),
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Icon(icon, color: iconColor, size: 23),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              shadows: [Shadow(color: Colors.black87, blurRadius: 4)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeAndCategoryBadge() {
    final isRequest = widget.post.type == AssistanceType.request;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRequest ? HawkarColors.accentAmber : HawkarColors.primaryMint,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            isRequest ? "داواکاری" : "پێشکەشکردن",
            style: TextStyle(
              color: isRequest ? HawkarColors.logoChampagne : HawkarColors.primaryMint,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            " • ${widget.post.categoryNameKurdish}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        gradient: HawkarColors.rubySunsetGradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_rounded, color: Colors.white, size: 12),
          SizedBox(width: 2),
          Text(
            "بەپەلە",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
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
      height: 48,
      decoration: BoxDecoration(
        gradient: _hasOfferedHelp ? null : HawkarColors.brandGradient,
        color: _hasOfferedHelp ? HawkarColors.surfaceElevated : null,
        borderRadius: BorderRadius.circular(14),
        border: _hasOfferedHelp
            ? Border.all(color: HawkarColors.primaryMint, width: 1.5)
            : null,
        boxShadow: _hasOfferedHelp
            ? null
            : [
                BoxShadow(
                  color: HawkarColors.primaryMint.withOpacity(0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: _openDetailsSheet,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _hasOfferedHelp
                  ? Icons.check_circle_rounded
                  : (isRequest ? Icons.volunteer_activism_rounded : Icons.handshake_rounded),
              color: _hasOfferedHelp ? HawkarColors.primaryMint : Colors.black,
              size: 19,
            ),
            const SizedBox(width: 8),
            Text(
              _hasOfferedHelp
                  ? "ئامادەییت تۆمارکرا ($_helperCount هاوکار)"
                  : (isRequest
                      ? "دەتوانم یارمەتی بدەم • $_helperCount هاوکار"
                      : "داواکردنی ئەم هاوکارییە"),
              style: TextStyle(
                color: _hasOfferedHelp ? HawkarColors.primaryMint : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
