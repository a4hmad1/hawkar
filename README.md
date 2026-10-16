# 🌟 Hawkar (هاوکار) — Community Assistance & Collaboration Platform

> **Hawkar (هاوکار)** is a community-driven mutual assistance mobile application built with **Flutter**, combining **TikTok's full-screen vertical video feed**, **Facebook's community trust mechanics**, **Snapchat's visual storytelling**, and **Telegram's clean, privacy-first communication**.

---

## 📱 Features

1. **TikTok-Style Vertical Feed (`PageView.builder`)**:
   - Full-bleed video and photo cards with gradient overlays.
   - Right floating action rail: User avatar, Respects/Likes, Comments, Share, and Bookmark.
   - Prominent **"دەتوانم یارمەتی بدەم" (I Can Help)** button with dynamic helper counter.
   - Interactive **Assistance Details Sheet** modal showing full descriptions, addresses, budget, and direct contact options.

2. **Kurdish Sorani Onboarding Experience**:
   - 4 welcoming, culturally authentic onboarding steps written in natural Sorani dialect explaining:
     - The mission of community assistance.
     - How to request help with video and location.
     - How to offer help to neighbors and citizens.
     - Community trust, safety, and privacy guidelines.

3. **Culturally Sensitive Privacy & Profile System**:
   - **Guest Browsing:** Anyone can browse the feed with zero friction.
   - **Auth Gate:** Login required only when creating posts or offering help.
   - **Google Sign-In, Facebook Login, and Email Authentication.**
   - **Gender-Sensitive Verification:**
     - Male users upload a photo for accountability.
     - Female users are provided protected illustrated privacy avatars to respect cultural preferences, backed by optional private ID verification for an official `Verified ID` badge.

4. **Post Creation Flow**:
   - Seamless switcher between **"داواکاریی هاوکاری" (Request Help)** and **"پێشکەشکردنی هاوکاری" (Offer Help)**.
   - Media upload preview (video/photo).
   - Category chips: Medical, Financial, Skills, Education, Daily Help, Emergency.
   - Voluntary/Free toggle with custom budget & currency input.
   - Kurdish cities picker (Erbil, Sulaymaniyah, Duhok, Kirkuk, Halabja, Garmian, Zakho).

5. **Clean Feature-First Architecture**:
   - `lib/core/`: Theme tokens (`app_theme.dart`), Kurdish localization strings (`kurdish_strings.dart`).
   - `lib/features/feed/`: Domain models, mock data source, vertical post cards, details sheet, and main feed screen.
   - `lib/features/onboarding/`: Interactive animated carousel and Sorani copy.
   - `lib/features/post_creation/`: Category picker, media selector, and budget switch.
   - `lib/features/auth/`: Social login, guest mode, and privacy profile management.

---

## 🚀 Building & Exporting IPA

### 1. Codemagic (`codemagic.yaml`)
This repository includes a pre-configured [`codemagic.yaml`](codemagic.yaml).
1. Link this repository in **Codemagic**.
2. Select the **`ios-release`** workflow.
3. Click **Start new build**.
4. Download the ready-to-install **`Hawkar.ipa`** from the build artifacts!

### 2. GitHub Actions (`.github/workflows/build-ios.yml`)
Every push to `main` or `master` automatically triggers a macOS build runner that compiles and packages `Hawkar.ipa`, uploaded directly under **Actions $\rightarrow$ Artifacts**.

---

## 🛠️ Local Development

```bash
# Clone the repository
git clone https://github.com/a4hmad1/hawkar.git
cd hawkar

# Get dependencies
flutter pub get

# Run on connected device or simulator
flutter run
```

---

## 📜 License
MIT License. Developed for the community of Kurdistan and beyond.
