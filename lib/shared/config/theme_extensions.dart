import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 🎨 Theme Extensions for Custom POS-specific styling
/// Provides additional theming capabilities beyond Material 3

// ========== CUSTOM COLORS EXTENSION ==========
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.cashColor,
    required this.cardColor,
    required this.discountColor,
    required this.totalColor,
    required this.categoryColors,
    required this.gradientPrimary,
    required this.gradientSecondary,
    required this.gradientSuccess,
  });

  final Color cashColor;
  final Color cardColor;
  final Color discountColor;
  final Color totalColor;
  final List<Color> categoryColors;
  final LinearGradient gradientPrimary;
  final LinearGradient gradientSecondary;
  final LinearGradient gradientSuccess;

  @override
  CustomColors copyWith({
    Color? cashColor,
    Color? cardColor,
    Color? discountColor,
    Color? totalColor,
    List<Color>? categoryColors,
    LinearGradient? gradientPrimary,
    LinearGradient? gradientSecondary,
    LinearGradient? gradientSuccess,
  }) {
    return CustomColors(
      cashColor: cashColor ?? this.cashColor,
      cardColor: cardColor ?? this.cardColor,
      discountColor: discountColor ?? this.discountColor,
      totalColor: totalColor ?? this.totalColor,
      categoryColors: categoryColors ?? this.categoryColors,
      gradientPrimary: gradientPrimary ?? this.gradientPrimary,
      gradientSecondary: gradientSecondary ?? this.gradientSecondary,
      gradientSuccess: gradientSuccess ?? this.gradientSuccess,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;

    return CustomColors(
      cashColor: Color.lerp(cashColor, other.cashColor, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      discountColor: Color.lerp(discountColor, other.discountColor, t)!,
      totalColor: Color.lerp(totalColor, other.totalColor, t)!,
      categoryColors: categoryColors, // Lists don't lerp easily
      gradientPrimary: LinearGradient.lerp(
        gradientPrimary,
        other.gradientPrimary,
        t,
      )!,
      gradientSecondary: LinearGradient.lerp(
        gradientSecondary,
        other.gradientSecondary,
        t,
      )!,
      gradientSuccess: LinearGradient.lerp(
        gradientSuccess,
        other.gradientSuccess,
        t,
      )!,
    );
  }

  // Light theme instance
  static const light = CustomColors(
    cashColor: AppColors.cashColor,
    cardColor: AppColors.cardColor,
    discountColor: AppColors.discountColor,
    totalColor: AppColors.totalColor,
    categoryColors: AppColors.categoryColors,
    gradientPrimary: AppColors.primaryGradient,
    gradientSecondary: AppColors.secondaryGradient,
    gradientSuccess: AppColors.successGradient,
  );

  // Dark theme instance
  static const dark = CustomColors(
    cashColor: AppColors.successLight,
    cardColor: AppColors.primaryLight,
    discountColor: AppColors.secondaryLight,
    totalColor: AppColors.tertiaryLight,
    categoryColors: AppColors.categoryColors,
    gradientPrimary: AppColors.primaryGradient,
    gradientSecondary: AppColors.secondaryGradient,
    gradientSuccess: AppColors.successGradient,
  );
}

// ========== SPACING EXTENSION ==========
@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  final double xs; // 4.0
  final double sm; // 8.0
  final double md; // 16.0
  final double lg; // 24.0
  final double xl; // 32.0
  final double xxl; // 48.0

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;

    return AppSpacing(
      xs: (xs + (other.xs - xs) * t),
      sm: (sm + (other.sm - sm) * t),
      md: (md + (other.md - md) * t),
      lg: (lg + (other.lg - lg) * t),
      xl: (xl + (other.xl - xl) * t),
      xxl: (xxl + (other.xxl - xxl) * t),
    );
  }

  static const standard = AppSpacing(
    xs: 4.0,
    sm: 8.0,
    md: 16.0,
    lg: 24.0,
    xl: 32.0,
    xxl: 48.0,
  );
}

// ========== CORNER RADIUS EXTENSION ==========
@immutable
class AppRadius extends ThemeExtension<AppRadius> {
  const AppRadius({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.round,
  });

  final double sm; // 8.0
  final double md; // 12.0
  final double lg; // 16.0
  final double xl; // 24.0
  final double round; // 999.0

  @override
  AppRadius copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? round,
  }) {
    return AppRadius(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      round: round ?? this.round,
    );
  }

  @override
  AppRadius lerp(ThemeExtension<AppRadius>? other, double t) {
    if (other is! AppRadius) return this;

    return AppRadius(
      sm: (sm + (other.sm - sm) * t),
      md: (md + (other.md - md) * t),
      lg: (lg + (other.lg - lg) * t),
      xl: (xl + (other.xl - xl) * t),
      round: (round + (other.round - round) * t),
    );
  }

  static const standard = AppRadius(
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    round: 999.0,
  );
}

// ========== CONVENIENT EXTENSIONS ==========
extension ThemeExtensions on ThemeData {
  /// Get custom POS colors
  CustomColors get customColors =>
      extension<CustomColors>() ?? CustomColors.light;

  /// Get app spacing
  AppSpacing get spacing => extension<AppSpacing>() ?? AppSpacing.standard;

  /// Get app radius
  AppRadius get radius => extension<AppRadius>() ?? AppRadius.standard;
}

extension ContextThemeExtensions on BuildContext {
  /// Quick access to theme
  ThemeData get theme => Theme.of(this);

  /// Quick access to color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Quick access to text theme
  TextTheme get textTheme => theme.textTheme;

  /// Quick access to custom colors
  CustomColors get customColors => theme.customColors;

  /// Quick access to spacing
  AppSpacing get spacing => theme.spacing;

  /// Quick access to radius
  AppRadius get radius => theme.radius;

  /// Check if current theme is dark
  bool get isDarkTheme => theme.brightness == Brightness.dark;

  /// Get adaptive color based on theme
  Color adaptiveColor(Color lightColor, Color darkColor) {
    return isDarkTheme ? darkColor : lightColor;
  }
}

// ========== COMMON STYLE BUILDERS ==========
class AppStyles {
  AppStyles._();

  /// Build shadow for cards/containers
  static List<BoxShadow> buildShadow(
    BuildContext context, {
    double elevation = 1.0,
  }) {
    final isDark = context.isDarkTheme;
    final shadowColor = isDark ? Colors.black87 : Colors.black12;

    return [
      BoxShadow(
        color: shadowColor,
        blurRadius: elevation * 2,
        offset: Offset(0, elevation),
      ),
    ];
  }

  /// Build gradient container decoration
  static BoxDecoration buildGradientDecoration(
    BuildContext context, {
    required LinearGradient gradient,
    double borderRadius = 12.0,
    Color? borderColor,
    double borderWidth = 0,
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth)
          : null,
      boxShadow: buildShadow(context),
    );
  }

  /// Build surface container decoration
  static BoxDecoration buildSurfaceDecoration(
    BuildContext context, {
    double borderRadius = 12.0,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 0,
    double elevation = 1.0,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? context.colorScheme.surface,
      borderRadius: BorderRadius.circular(borderRadius),
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth)
          : null,
      boxShadow: buildShadow(context, elevation: elevation),
    );
  }

  /// Build status indicator decoration
  static BoxDecoration buildStatusDecoration(
    BuildContext context, {
    required Color color,
    double borderRadius = 8.0,
    bool isOutlined = false,
  }) {
    if (isOutlined) {
      return BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: color, width: 1.5),
      );
    }

    return BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
    );
  }
}
