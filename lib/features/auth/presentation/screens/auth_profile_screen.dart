import 'package:flutter/material.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/features/feed/domain/models/assistance_post.dart';

class AuthProfileScreen extends StatefulWidget {
  final bool isGuest;

  const AuthProfileScreen({super.key, this.isGuest = true});

  @override
  State<AuthProfileScreen> createState() => _AuthProfileScreenState();
}

class _AuthProfileScreenState extends State<AuthProfileScreen> {
  bool _isSignedIn = false;
  Gender _selectedGender = Gender.male;
  bool _usePrivacyAvatar = false;
  bool _isIdVerified = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HawkarColors.bgDark,
      appBar: AppBar(
        title: Text(_isSignedIn ? "هەژماری بەکارهێنەر" : "چوونەژوورەوە یان هەژمار"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: _isSignedIn ? _buildProfileView() : _buildAuthOptionsView(),
      ),
    );
  }

  Widget _buildAuthOptionsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: HawkarColors.surfaceElevated,
              shape: BoxShape.circle,
              border: Border.all(color: HawkarColors.primaryEmerald.withOpacity(0.5), width: 2),
            ),
            child: const Icon(Icons.handshake, size: 54, color: HawkarColors.primaryEmerald),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "بەخێربێن بۆ کۆمەڵگەی هاوکار",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: HawkarColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "دەتوانیت بەبێ هەژمار تەماشای پۆستەکان بکەیت؛ بەڵام بۆ داواکردن و پێشکەشکردنی هاوکاری، پێویستە بچیتە ژوورەوە.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: HawkarColors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // 1. Google Sign In Button
        _socialButton(
          title: "چوونەژوورەوە بە Google (Gmail)",
          icon: Icons.alternate_email_rounded,
          iconColor: Colors.redAccent,
          onTap: () {
            setState(() => _isSignedIn = true);
          },
        ),
        const SizedBox(height: 12),

        // 2. Facebook Login Button
        _socialButton(
          title: "چوونەژوورەوە بە Facebook",
          icon: Icons.facebook_rounded,
          iconColor: Colors.blueAccent,
          onTap: () {
            setState(() => _isSignedIn = true);
          },
        ),
        const SizedBox(height: 12),

        // 3. Email & Password Button
        _socialButton(
          title: "چوونەژوورەوە بە ناونیشانی ئیمەیڵ",
          icon: Icons.mail_lock_rounded,
          iconColor: HawkarColors.primaryEmerald,
          onTap: () {
            setState(() => _isSignedIn = true);
          },
        ),
        const SizedBox(height: 24),

        // Privacy Guarantee Card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: HawkarColors.surfaceElevated,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: HawkarColors.surfaceBorder),
          ),
          child: const Row(
            children: [
              Icon(Icons.shield_rounded, color: HawkarColors.accentGold, size: 22),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "زانیارییە کەسییەکانت بە پارێزراوی لای خۆمان دەمێننەوە و لەژێر کۆنترۆڵی تەواوی خۆتدایە.",
                  style: TextStyle(color: HawkarColors.textMuted, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Profile Header
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 46,
                backgroundColor: HawkarColors.surfaceElevated,
                backgroundImage: !_usePrivacyAvatar
                    ? const NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80")
                    : null,
                child: _usePrivacyAvatar
                    ? const Icon(Icons.shield_outlined, size: 40, color: HawkarColors.primaryEmerald)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: HawkarColors.primaryEmerald,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Name & Verification Badge
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "ڕێبین عەلی مەحمود",
                style: TextStyle(
                  color: HawkarColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_isIdVerified) ...[
                const SizedBox(width: 6),
                const Icon(Icons.verified, color: HawkarColors.accentBlue, size: 20),
              ],
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Center(
          child: Text(
            "هەولێر • ئەندام لە ئازاری ٢٠٢٦ • پلەی متمانە: ٩٨٪",
            style: TextStyle(color: HawkarColors.textMuted, fontSize: 13),
          ),
        ),
        const SizedBox(height: 24),

        // Verification & Privacy Settings Section
        const Text(
          "ڕێکخستنەکانی ناسنامە و پاراستنی نهێنی",
          style: TextStyle(
            color: HawkarColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Gender & Photo Policy Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: HawkarColors.surfaceElevated,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: HawkarColors.surfaceBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "ڕەگەز دیاری بکە",
                style: TextStyle(color: HawkarColors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _genderRadio(Gender.male, "نێر (پیاو)"),
                  const SizedBox(width: 16),
                  _genderRadio(Gender.female, "مێ (خانم)"),
                ],
              ),
              const Divider(color: HawkarColors.surfaceBorder, height: 24),

              if (_selectedGender == Gender.female) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "بەکارهێنانی ئاڤاتاری پارێزراو",
                            style: TextStyle(color: HawkarColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "وەک ڕێزێک بۆ کلتوور و ئارەزووی خۆت، ناچاری دانانی وێنەی ڕاستەقینە نیت و هەژمارەکەت بە تەواوی متمانەپێکراو دەبێت.",
                            style: TextStyle(color: HawkarColors.textMuted, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _usePrivacyAvatar,
                      activeColor: HawkarColors.primaryEmerald,
                      onChanged: (val) => setState(() => _usePrivacyAvatar = val),
                    ),
                  ],
                ),
              ] else ...[
                const Row(
                  children: [
                    Icon(Icons.face, color: HawkarColors.primaryEmerald, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "دانانی وێنەی کەسی بۆ پیاوان متمانەی داواکارییەکان زیاتر دەکات لەناو کۆمەڵگەدا.",
                        style: TextStyle(color: HawkarColors.textMuted, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Verified Badge Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: HawkarColors.surfaceDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: HawkarColors.primaryEmerald.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              const Icon(Icons.shield_outlined, color: HawkarColors.primaryEmerald, size: 28),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ناسنامەی پشتڕاستکراوە (Verified ID)",
                      style: TextStyle(color: HawkarColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "بە بەڵگەنامەی فەرمی هەژمارەکەت پەسەندکراوە و باجی شینت وەرگرتووە.",
                      style: TextStyle(color: HawkarColors.textMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("وردەکاری", style: TextStyle(color: HawkarColors.primaryEmerald)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Sign Out Button
        OutlinedButton(
          onPressed: () => setState(() => _isSignedIn = false),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: HawkarColors.surfaceBorder),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text(
            "دەرچوون لە هەژمار",
            style: TextStyle(color: HawkarColors.accentRuby, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _genderRadio(Gender gender, String title) {
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
          if (gender == Gender.female) {
            _usePrivacyAvatar = true;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? HawkarColors.primaryEmerald : HawkarColors.surfaceDark,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? HawkarColors.primaryEmerald : HawkarColors.surfaceBorder,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : HawkarColors.textSecondary,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required String title,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: HawkarColors.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: HawkarColors.surfaceBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: HawkarColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.arrow_back_ios_new_rounded, color: HawkarColors.textMuted, size: 14),
          ],
        ),
      ),
    );
  }
}
