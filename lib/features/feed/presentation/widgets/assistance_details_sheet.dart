import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/features/feed/domain/models/assistance_post.dart';

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
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          decoration: BoxDecoration(
            color: HawkarColors.surfaceDark.withOpacity(0.92),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 48,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Header: Author Profile & Verification
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: post.type == AssistanceType.request
                            ? HawkarColors.accentGold
                            : HawkarColors.primaryEmerald,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: HawkarColors.surfaceElevated,
                      backgroundImage: post.author.avatarUrl != null
                          ? NetworkImage(post.author.avatarUrl!)
                          : null,
                      child: post.author.avatarUrl == null
                          ? const Icon(
                              Icons.shield_rounded,
                              color: HawkarColors.primaryEmerald,
                              size: 24,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 14),
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
                                fontWeight: FontWeight.w800,
                                fontSize: 16.5,
                              ),
                            ),
                            if (post.author.isVerified) ...[
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.verified_rounded,
                                color: HawkarColors.accentBlue,
                                size: 17,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "پلەی متمانە: ${post.author.trustScore}% • لە ${post.locationCity}",
                          style: const TextStyle(
                            color: HawkarColors.textMuted,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: HawkarColors.textSecondary,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(color: HawkarColors.surfaceBorder, height: 26),

              // Post Title
              Text(
                post.title,
                style: const TextStyle(
                  color: HawkarColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.5,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),

              // Full Details Text
              Text(
                post.details,
                style: const TextStyle(
                  color: HawkarColors.textSecondary,
                  fontSize: 14,
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 18),

              // Metadata Pills
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _infoPill(Icons.category_rounded, post.categoryNameKurdish),
                  _infoPill(Icons.place_rounded, post.locationAddress),
                  _infoPill(
                    Icons.account_balance_wallet_rounded,
                    post.formattedBudget,
                    isHighlight: !post.isFree,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Security & Privacy Alert Box
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: HawkarColors.bgDark.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: HawkarColors.surfaceBorder),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.privacy_tip_rounded, color: HawkarColors.accentGold, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "بۆ پاراستنی هەردوولا، هەرگیز کۆدی تایبەت یان زانیاری بانکی بۆ کەس مەنێرە.",
                        style: TextStyle(
                          color: HawkarColors.textMuted,
                          fontSize: 11.5,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Primary Action Button
              Container(
                decoration: BoxDecoration(
                  gradient: post.type == AssistanceType.request
                      ? HawkarColors.emeraldGradient
                      : HawkarColors.amberGoldGradient,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: (post.type == AssistanceType.request
                              ? HawkarColors.primaryEmerald
                              : HawkarColors.accentGold)
                          .withOpacity(0.4),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onHelpOffered();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        post.type == AssistanceType.request
                            ? Icons.volunteer_activism_rounded
                            : Icons.handshake_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        post.type == AssistanceType.request
                            ? "دەتوانم یارمەتی بدەم"
                            : "داواکردنی هاوکاری لەم کەسە",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoPill(IconData icon, String text, {bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6.5),
      decoration: BoxDecoration(
        color: isHighlight
            ? HawkarColors.accentAmber.withOpacity(0.16)
            : HawkarColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isHighlight
              ? HawkarColors.accentAmber.withOpacity(0.45)
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
