import 'package:flutter/material.dart';

/// 🎨 Comprehensive Color System for POS Application
/// Supporting both Light and Dark themes with modern, accessible colors
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ========== BRAND COLORS ==========
  // Primary Brand Colors (Modern Blue-Green)
  static const Color primary = Color(0xFF1565C0); // Deep Blue
  static const Color primaryLight = Color(0xFF5E92F3); // Light Blue
  static const Color primaryDark = Color(0xFF003C8F); // Dark Blue
  static const Color primaryContainer = Color(0xFFD1E4FF); // Very Light Blue

  // Secondary Brand Colors (Complementary Orange)
  static const Color secondary = Color(0xFFFF6D00); // Vibrant Orange
  static const Color secondaryLight = Color(0xFFFF9E40); // Light Orange
  static const Color secondaryDark = Color(0xFFE65100); // Dark Orange
  static const Color secondaryContainer = Color(
    0xFFFFE0B2,
  ); // Very Light Orange

  // Tertiary Colors (Purple for accents)
  static const Color tertiary = Color(0xFF7C4DFF); // Purple
  static const Color tertiaryLight = Color(0xFFB085F5); // Light Purple
  static const Color tertiaryDark = Color(0xFF512DA8); // Dark Purple
  static const Color tertiaryContainer = Color(0xFFE1BEE7); // Very Light Purple

  // ========== LIGHT THEME COLORS ==========
  static const Color lightBackground = Color(
    0xFFFCFCFC,
  ); // putih kebiruan background
  static const Color lightSurface = Color.fromARGB(
    255,
    236,
    236,
    240,
  ); // White surface
  static const Color lightSurfaceVariant = Color(
    0xFFF5F5F5,
  ); // Light gray surface
  static const Color lightOutline = Color(0xFFE0E0E0); // Light outline
  static const Color lightOutlineVariant = Color(
    0xFFF0F0F0,
  ); // Very light outline

  // Light Theme Text Colors
  static const Color lightOnBackground = Color(0xFF1A1A1A); // Almost black
  static const Color lightOnSurface = Color(0xFF1A1A1A); // Almost black
  static const Color lightOnSurfaceVariant = Color(0xFF5F5F5F); // Medium gray
  static const Color lightOnPrimary = Color(0xFFFFFFFF); // White
  static const Color lightOnSecondary = Color(0xFFFFFFFF); // White
  static const Color lightOnTertiary = Color(0xFFFFFFFF); // White

  // ========== DARK THEME COLORS ==========
  static const Color darkBackground = Color(0xFF0F0F0F); // Very dark background
  static const Color darkSurface = Color(0xFF1A1A1A); // Dark surface
  static const Color darkSurfaceVariant = Color(
    0xFF2A2A2A,
  ); // Medium dark surface
  static const Color darkOutline = Color(0xFF404040); // Dark outline
  static const Color darkOutlineVariant = Color(
    0xFF2A2A2A,
  ); // Medium dark outline

  // Dark Theme Text Colors
  static const Color darkOnBackground = Color(0xFFE6E6E6); // Light gray
  static const Color darkOnSurface = Color(0xFFE6E6E6); // Light gray
  static const Color darkOnSurfaceVariant = Color(0xFFB3B3B3); // Medium gray
  static const Color darkOnPrimary = Color(0xFFFFFFFF); // White
  static const Color darkOnSecondary = Color(0xFF000000); // Black
  static const Color darkOnTertiary = Color(0xFFFFFFFF); // White

  // ========== STATUS COLORS ==========
  static const Color success = Color(0xFF2E7D0F); // Dark green
  static const Color successLight = Color(0xFF4CAF50); // Light green
  static const Color successContainer = Color(0xFFC8E6C9); // Very light green

  static const Color warning = Color(0xFFED6C02); // Orange warning
  static const Color warningLight = Color(0xFFFF9800); // Light orange
  static const Color warningContainer = Color(0xFFFFE0B2); // Very light orange

  static const Color error = Color(0xFFD32F2F); // Red error
  static const Color errorLight = Color(0xFFEF5350); // Light red
  static const Color errorContainer = Color(0xFFFFCDD2); // Very light red

  static const Color info = Color(0xFF0288D1); // Blue info
  static const Color infoLight = Color(0xFF29B6F6); // Light blue
  static const Color infoContainer = Color(0xFFB3E5FC); // Very light blue

  // ========== SEMANTIC COLORS ==========
  // POS Specific Colors
  static const Color cashColor = Color(0xFF2E7D0F); // Green for cash
  static const Color cardColor = Color(0xFF1565C0); // Blue for card
  static const Color discountColor = Color(0xFFFF6D00); // Orange for discount
  static const Color totalColor = Color(0xFF7C4DFF); // Purple for total

  // Category Colors (for visual distinction)
  static const List<Color> categoryColors = [
    Color(0xFFE3F2FD), // Light Blue
    Color(0xFFF3E5F5), // Light Purple
    Color(0xFFE8F5E8), // Light Green
    Color(0xFFFFF3E0), // Light Orange
    Color(0xFFFCE4EC), // Light Pink
    Color(0xFFE0F2F1), // Light Teal
    Color(0xFFF1F8E9), // Light Lime
    Color(0xFFFFF8E1), // Light Yellow
  ];

  // ========== GRADIENTS ==========
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF1A1A1A), Color(0xFF2A2A2A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ========== UTILITY METHODS ==========
  /// Get color based on theme brightness
  static Color getAdaptiveColor(
    Brightness brightness,
    Color lightColor,
    Color darkColor,
  ) {
    return brightness == Brightness.light ? lightColor : darkColor;
  }

  /// Get surface color based on elevation (Material 3 style)
  static Color getSurfaceElevated(
    Brightness brightness, [
    double elevation = 1.0,
  ]) {
    if (brightness == Brightness.light) {
      return lightSurface;
    } else {
      // In dark theme, elevated surfaces get lighter
      final opacity = (0.05 * elevation).clamp(0.0, 0.15);
      return Color.alphaBlend(
        Colors.white.withValues(alpha: opacity),
        darkSurface,
      );
    }
  }

  // ========== BACKWARD COMPATIBILITY ==========
  // Keeping old color names for existing code compatibility
  static const Color accent = secondary; // Use secondary as accent
  static const Color accentLight =
      secondaryLight; // Use secondaryLight as accentLight
  static const Color background =
      lightBackground; // Use lightBackground as background
  static const Color surface = lightSurface; // Use lightSurface as surface
  static const Color divider = lightOutline; // Use lightOutline as divider
  static const Color textPrimary =
      lightOnSurface; // Use lightOnSurface as textPrimary
  static const Color textSecondary =
      lightOnSurfaceVariant; // Use lightOnSurfaceVariant as textSecondary
  static const Color textOnPrimary =
      lightOnPrimary; // Use lightOnPrimary as textOnPrimary
  static const Color textOnAccent =
      lightOnSecondary; // Use lightOnSecondary as textOnAccent
  static const Color surfaceDark =
      darkSurface; // Use darkSurface as surfaceDark
  static const Color backgroundDark =
      darkBackground; // Use darkBackground as backgroundDark
}
