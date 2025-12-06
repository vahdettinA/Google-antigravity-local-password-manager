import 'package:flutter/material.dart';
import '../models/password_entry.dart';

class AppColors {
  static const Color primary = Color(
    0xFFE53935,
  ); // Reddish like the plus button in image
  static const Color background = Colors.white;
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF86868B);

  static const Color primaryLow = Color(0x1AE53935); // 10% opacity
  static const Color primaryMedium = Color(0x80E53935); // 50% opacity
  static const Color blackLow = Color(0x0D000000); // 5% opacity
  static const Color blackVeryLow = Color(0x08000000); // 3% opacity
}

class PlatformOption {
  final String name;
  final String logoPath;
  final PlatformCategory category;

  const PlatformOption({
    required this.name,
    required this.logoPath,
    required this.category,
  });
}

class AppAssets {
  static const List<PlatformOption> platforms = [
    // Mail
    PlatformOption(
      name: 'Google',
      logoPath: 'assets/mail/google.png',
      category: PlatformCategory.mail,
    ),
    PlatformOption(
      name: 'Microsoft',
      logoPath: 'assets/mail/microsoft.png',
      category: PlatformCategory.mail,
    ),

    // Bank
    PlatformOption(
      name: 'Halkbank',
      logoPath: 'assets/bank/halk.jpg',
      category: PlatformCategory.bank,
    ),
    PlatformOption(
      name: 'İş Bankası',
      logoPath: 'assets/bank/iş.png',
      category: PlatformCategory.bank,
    ),
    PlatformOption(
      name: 'Yapı Kredi',
      logoPath: 'assets/bank/yapı.png',
      category: PlatformCategory.bank,
    ),
    PlatformOption(
      name: 'Ziraat Bankası',
      logoPath: 'assets/bank/ziraat.png',
      category: PlatformCategory.bank,
    ),

    // Movie
    PlatformOption(
      name: 'Amazon Prime',
      logoPath: 'assets/movie/amazon.png',
      category: PlatformCategory.movie,
    ),
    PlatformOption(
      name: 'HBO',
      logoPath: 'assets/movie/hbo.png',
      category: PlatformCategory.movie,
    ),
    PlatformOption(
      name: 'Netflix',
      logoPath: 'assets/movie/netflix.png',
      category: PlatformCategory.movie,
    ),
    PlatformOption(
      name: 'Tabii',
      logoPath: 'assets/movie/tabii.jpg',
      category: PlatformCategory.movie,
    ),
  ];

  static const PlatformOption otherOption = PlatformOption(
    name: 'Diğer',
    logoPath: '', // Will use icon
    category: PlatformCategory.other,
  );
}
