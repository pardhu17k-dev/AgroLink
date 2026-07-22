import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── Brand Colors ────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF10B981); // Emerald Green
  static const Color primaryLight = Color(0xFF34D399);
  static const Color primaryDark = Color(0xFF059669);
  static const Color primarySubtle = Color(0xFFD1FAE5); // Very light green bg

  // ─── Accent ──────────────────────────────────────────────────────────────
  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color accentLight = Color(0xFFFDE68A);
  static const Color accentSubtle = Color(0xFFFEF3C7);

  // ─── Semantic Colors ──────────────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color successSubtle = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSubtle = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorSubtle = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoSubtle = Color(0xFFEFF6FF);

  // ─── Neutrals ─────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF8FAFC); // Very light slate
  static const Color surface = Colors.white;
  static const Color surfaceElevated = Color(0xFFF1F5F9); // Slightly grey

  // ─── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textTertiary = Color(0xFF94A3B8); // Slate 400
  static const Color textOnPrimary = Colors.white;

  // ─── Borders & Dividers ───────────────────────────────────────────────────
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color divider = Color(0xFFF1F5F9); // Slate 100

  // ─── Shadows ──────────────────────────────────────────────────────────────
  static List<BoxShadow> get shadowSmall => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.07),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLarge => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.10),
          blurRadius: 32,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get shadowPrimary => [
        BoxShadow(
          color: primary.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];

  // ─── Gradients ────────────────────────────────────────────────────────────
  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );

  static const LinearGradient gradientAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, Color(0xFFD97706)],
  );

  static const LinearGradient gradientBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFECFDF5), Color(0xFFF8FAFC)],
  );

  // ─── Border Radius ────────────────────────────────────────────────────────
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXL = 20.0;
  static const double radius2XL = 24.0;

  // ─── Theme ────────────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: accent,
        surface: surface,
        error: error,
      ),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 48,
        ),
        displayMedium: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        displaySmall: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
        headlineLarge: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
        headlineMedium: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        headlineSmall: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleLarge: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        titleSmall: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        bodyLarge: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 16,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 14,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.inter(
          color: textTertiary,
          fontSize: 12,
          height: 1.4,
        ),
        labelLarge: GoogleFonts.inter(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        labelMedium: GoogleFonts.inter(
          color: textSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        labelSmall: GoogleFonts.inter(
          color: textTertiary,
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: primary),
        titleTextStyle: GoogleFonts.outfit(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXL),
          side: const BorderSide(color: divider, width: 1),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.06),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLarge)),
          textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLarge)),
          textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: GoogleFonts.inter(color: textTertiary, fontSize: 14),
        labelStyle: GoogleFonts.inter(color: textSecondary, fontSize: 14),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: textTertiary,
        selectedLabelStyle:
            GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 11),
        unselectedLabelStyle:
            GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 11),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      dividerTheme: const DividerThemeData(
        color: divider,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceElevated,
        selectedColor: primarySubtle,
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          side: const BorderSide(color: border),
        ),
        side: const BorderSide(color: border),
        showCheckmark: false,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimary,
        contentTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius2XL)),
        titleTextStyle: GoogleFonts.outfit(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
