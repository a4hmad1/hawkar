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

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.respectCount;
    _helperCount = widget.post.helperCount;
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Icon(
              _hasOfferedHelp ? Icons.check_circle : Icons.info_outline,
              color: _hasOfferedHelp ? HawkarColors.primaryEmerald : HawkarColors.textMuted,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _hasOfferedHelp
                    ? "ئامادەییت بۆ هاوکاری تۆمارکرا! داواکار ئاگادارکرایەوە."
                    : "هاوکارییەکەت هەڵوەشێنرایەوە.",
                style: const TextStyle(color: HawkarColors.textPrimary, fontSize: 13),
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

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Background Media (Photo / Video Frame)
        Image.network(
          widget.post.mediaUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: HawkarColors.bgDark,
              child: const Center(
                child: CircularProgressIndicator(color: HawkarColors.primaryEmerald),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: HawkarColors.surfaceDark,
            child: const Center(
              child: Icon(Icons.broken_image_outlined, size: 60, color: HawkarColors.textMuted),
            ),
          ),
        ),

        // 2. Dark Gradient Vignette for Readability
        Container(
          decoration: const BoxDecoration(
            gradient: HawkarColors.overlayGradient,
          ),
        ),

        // 3. Top Gradient for Status Bar & Header
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 120,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // 4. Right Side Floating Action Rail (TikTok Style)
        Positioned(
          right: 14,
          bottom: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // User Avatar with Badge
              _buildAuthorAvatar(),
              const SizedBox(height: 18),

              // Heart / Respect
              _buildActionIcon(
                icon: _isLiked ? Icons.favorite : Icons.favorite_border,
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
                icon: Icons.chat_bubble_outline,
                label: "${widget.post.commentCount}",
                onTap: _openDetailsSheet,
              ),
              const SizedBox(height: 16),

              // Save / Bookmark
              _buildActionIcon(
                icon: _isSaved ? Icons.bookmark : Icons.bookmark_border,
                iconColor: _isSaved ? HawkarColors.accentGold : Colors.white,
                label: "پاشەکەوت",
                onTap: () {
                  setState(() => _isSaved = !_isSaved);
                },
              ),
              const SizedBox(height: 16),

              // Share
              _buildActionIcon(
                icon: Icons.share_outlined,
                label: "هاوبەشکردن",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("بەستەری پۆست لەبەرگیرایەوە")),
                  );
                },
              ),
            ],
          ),
        ),

        // 5. Bottom Overlay: Clean Information & Call to Action
        Positioned(
          left: 16,
          right: 80, // Leave space for action rail
          bottom: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Type & Category Chips
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
              const SizedBox(height: 10),

              // Author Name
              Row(
                children: [
                  Text(
                    widget.post.author.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.post.author.isVerified) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.verified, color: HawkarColors.accentBlue, size: 16),
                  ],
                ],
              ),
              const SizedBox(height: 6),

              // Post Title
              Text(
                widget.post.title,
                style: const TextStyle(
                  color: HawkarColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
              ),
              const SizedBox(height: 6),

              // Description
              GestureDetector(
                onTap: () {
                  setState(() => _isDescriptionExpanded = !_isDescriptionExpanded);
                },
                child: Text(
                  widget.post.description,
                  maxLines: _isDescriptionExpanded ? 10 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Budget & Location Tag
              Row(
                children: [
                  if (!widget.post.isFree && widget.post.amount != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: HawkarColors.accentAmber.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: HawkarColors.accentAmber.withOpacity(0.6)),
                      ),
                      child: Text(
                        widget.post.formattedBudget,
                        style: const TextStyle(
                          color: HawkarColors.accentGold,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: HawkarColors.primaryEmerald, size: 15),
                      const SizedBox(width: 4),
                      Text(
                        widget.post.locationCity,
                        style: const TextStyle(
                          color: HawkarColors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Big "I Can Help / دەتوانم یارمەتی بدەم" Button
              _buildMainHelpButton(),
            ],
          ),
        ),
      ],
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
              border: Border.all(
                color: widget.post.type == AssistanceType.request
                    ? HawkarColors.accentAmber
                    : HawkarColors.primaryEmerald,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: HawkarColors.surfaceElevated,
              backgroundImage: widget.post.author.avatarUrl != null
                  ? NetworkImage(widget.post.author.avatarUrl!)
                  : null,
              child: widget.post.author.avatarUrl == null
                  ? const Icon(Icons.person, color: HawkarColors.textMuted)
                  : null,
            ),
          ),
          Positioned(
            bottom: -6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: HawkarColors.primaryEmerald,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 12, color: Colors.black),
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black38,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 0.8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
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

  Widget _buildTypeBadge() {
    final isRequest = widget.post.type == AssistanceType.request;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isRequest ? HawkarColors.accentAmber : HawkarColors.primaryEmerald,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: (isRequest ? HawkarColors.accentAmber : HawkarColors.primaryEmerald).withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        isRequest ? "داواکاری" : "پێشکەشکردن",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white30, width: 0.8),
      ),
      child: Text(
        widget.post.categoryNameKurdish,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildUrgentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: HawkarColors.accentRuby,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: Colors.white, size: 12),
          SizedBox(width: 2),
          Text(
            "بەپەلە",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainHelpButton() {
    final isRequest = widget.post.type == AssistanceType.request;

    return ElevatedButton(
      onPressed: _openDetailsSheet,
      style: ElevatedButton.styleFrom(
        backgroundColor: _hasOfferedHelp
            ? HawkarColors.surfaceElevated
            : (isRequest ? HawkarColors.primaryEmerald : HawkarColors.accentGold),
        foregroundColor: _hasOfferedHelp ? HawkarColors.primaryEmerald : Colors.black,
        elevation: 6,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: _hasOfferedHelp
              ? const BorderSide(color: HawkarColors.primaryEmerald, width: 1.5)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _hasOfferedHelp ? Icons.check : (isRequest ? Icons.volunteer_activism : Icons.handshake),
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            _hasOfferedHelp
                ? "ئامادەییت تۆمارکرا ($_helperCount)"
                : (isRequest ? "دەتوانم یارمەتی بدەم ($_helperCount)" : "داواکردنی ئەم هاوکارییە"),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
