enum AssistanceType {
  request, // داواکاری یارمەتی
  offer,   // پێشکەشکردنی هاوکاری
}

enum AssistanceCategory {
  medical,
  financial,
  skills,
  education,
  dailyHelp,
  emergency,
}

enum Gender {
  male,
  female,
  preferNotToSay,
}

class HawkarUser {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isVerified;
  final Gender gender;
  final double trustScore; // 0.0 to 100.0
  final bool isAnonymousAvatar;

  const HawkarUser({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.isVerified = false,
    required this.gender,
    this.trustScore = 95.0,
    this.isAnonymousAvatar = false,
  });
}

class AssistancePost {
  final String id;
  final String title;
  final String description;
  final String details;
  final AssistanceType type;
  final AssistanceCategory category;
  final double? amount;
  final String currency;
  final bool isFree;
  final bool isUrgent;
  final String locationCity;
  final String locationAddress;
  final String mediaUrl;
  final bool isVideo;
  final HawkarUser author;
  final int helperCount;
  final int respectCount;
  final int commentCount;
  final DateTime createdAt;
  final bool isCompleted;

  const AssistancePost({
    required this.id,
    required this.title,
    required this.description,
    required this.details,
    required this.type,
    required this.category,
    this.amount,
    this.currency = "IQD",
    this.isFree = true,
    this.isUrgent = false,
    required this.locationCity,
    required this.locationAddress,
    required this.mediaUrl,
    this.isVideo = true,
    required this.author,
    this.helperCount = 0,
    this.respectCount = 0,
    this.commentCount = 0,
    required this.createdAt,
    this.isCompleted = false,
  });

  String get categoryNameKurdish {
    switch (category) {
      case AssistanceCategory.medical:
        return "تەندروستی و دەرمان";
      case AssistanceCategory.financial:
        return "یارمەتی دارایی";
      case AssistanceCategory.skills:
        return "شارەزایی و پیشە";
      case AssistanceCategory.education:
        return "فێرکاری و دەرس";
      case AssistanceCategory.dailyHelp:
        return "هاوکاری ڕۆژانە";
      case AssistanceCategory.emergency:
        return "فریاکەوتنی بەپەلە";
    }
  }

  String get formattedBudget {
    if (isFree || amount == null || amount == 0) {
      return "خۆبەخشانە / بێبەرامبەر";
    }
    return "${amount!.toInt()} $currency";
  }
}
