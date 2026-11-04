import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const Color bgLavender = Color(0xFFFAF8FF);
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgGrey = Color(0xFFF1F5F9);
  static const Color bgGreyAlt = Color(0xFFF3F4F6);

  // Text primary
  static const Color textPrimary = Color(0xFF131B2E);
  static const Color textPrimaryAlt = Color(0xFF0F172A);
  static const Color textPrimaryDark = Color(0xFF111827);

  // Text secondary
  static const Color textSecondaryWarm = Color(0xFF5C3F3E);
  static const Color textSecondarySlate = Color(0xFF475569);
  static const Color textSecondaryLight = Color(0xFF64748B);

  // Muted
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textMutedAlt = Color(0xFF9CA3AF);

  // Red
  static const Color redPrimary = Color(0xFFBA0022);
  static const Color redDark = Color(0xFFDC2626);
  static const Color redDeep = Color(0xFFC62828);
  static const Color redBright = Color(0xFFE53935);

  // Blue
  static const Color bluePrimary = Color(0xFF0051D5);
  static const Color blueMedium = Color(0xFF2563EB);
  static const Color blueLight = Color(0xFF3B82F6);

  // Blue surface
  static const Color blueSurface1 = Color(0xFFF2F3FF);
  static const Color blueSurface2 = Color(0xFFEAEDFF);
  static const Color blueSurface3 = Color(0xFFDBE1FF);

  // Red surface
  static const Color redSurface1 = Color(0xFFFFDAD6);
  static const Color redSurface2 = Color(0xFFFFDAD8);
  static const Color redSurface3 = Color(0xFFFEF2F2);

  // Green
  static const Color green = Color(0xFF10B981);
  static const Color greenDark = Color(0xFF059669);

  // Amber
  static const Color amber = Color(0xFFF59E0B);
  static const Color amberLight = Color(0xFFFFDDB8);
}

class AppTextStyles {
  // Plus Jakarta Sans
  static const String fontPlusJakarta = 'PlusJakartaSans';
  // Liberation Sans
  static const String fontLiberation = 'LiberationSans';

  static TextStyle plusJakarta({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) =>
      TextStyle(
        fontFamily: fontPlusJakarta,
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle liberation({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) =>
      TextStyle(
        fontFamily: fontLiberation,
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

class AppRadius {
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 24;
  static const double pill = 100;
}

class AppShadows {
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> elevated = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
