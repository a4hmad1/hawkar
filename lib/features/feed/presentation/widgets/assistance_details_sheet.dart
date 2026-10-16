import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/assistance_post.dart';

class AssistanceDetailsSheet extends StatelessWidget {
  final AssistancePost post;
  final VoidCallback onHelpOffered;

  const AssistanceDetailsSheet({
    super.key,
    required this.post,
    required this.onHelpOffered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: HawkarColors.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: HawkarColors.surfaceBorder, width: 1.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: HawkarColors.textMuted.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: HawkarColors.surfaceElevated,
                backgroundImage: post.author.avatarUrl != null
                    ? NetworkImage(post.author.avatarUrl!)
                    : null,
                child: post.author.avatarUrl == null
                    ? const Icon(Icons.shield_outlined, color: HawkarColors.primaryEmerald)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.author.name,
                          style: const TextStyle(
                            color: HawkarColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (post.author.isVerified) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.verified, color: HawkarColors.accentBlue, size: 16),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "پلەی متمانە: ${post.author.trustScore}% • لە ${post.locationCity}",
                      style: const TextStyle(
                        color: HawkarColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: HawkarColors.textSecondary),
              ),
            ],
          ),

          const Divider(color: HawkarColors.surfaceBorder, height: 28),

          // Details Content
          Text(
            post.title,
            style: const TextStyle(
              color: HawkarColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            post.details,
            style: const TextStyle(
              color: HawkarColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),

          // Metadata Badges
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _infoPill(Icons.category_outlined, post.categoryNameKurdish),
              _infoPill(Icons.place_outlined, post.locationAddress),
              _infoPill(
                Icons.account_balance_wallet_outlined,
                post.formattedBudget,
                isHighlight: !post.isFree,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Community Safety Alert
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: HawkarColors.bgDark.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: HawkarColors.surfaceBorder),
            ),
            child: const Row(
              children: [
                Icon(Icons.privacy_tip_outlined, color: HawkarColors.accentGold, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "بۆ پاراستنی هەردوولا، هەرگیز زانیاری بانکی یان کۆدی نهێنی بە کەس مەدە.",
                    style: TextStyle(color: HawkarColors.textMuted, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Direct Action Button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onHelpOffered();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: post.type == AssistanceType.request
                  ? HawkarColors.primaryEmerald
                  : HawkarColors.accentGold,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  post.type == AssistanceType.request ? Icons.volunteer_activism : Icons.handshake,
                  color: Colors.black,
                ),
                const SizedBox(width: 8),
                Text(
                  post.type == AssistanceType.request ? "دەتوانم یارمەتی بدەم" : "داواکردنی هاوکاری لەم کەسە",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _infoPill(IconData icon, String text, {bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isHighlight
            ? HawkarColors.accentAmber.withOpacity(0.15)
            : HawkarColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHighlight
              ? HawkarColors.accentAmber.withOpacity(0.4)
              : HawkarColors.surfaceBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isHighlight ? HawkarColors.accentAmber : HawkarColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: isHighlight ? HawkarColors.accentGold : HawkarColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
