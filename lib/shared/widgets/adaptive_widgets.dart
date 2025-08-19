import 'package:flutter/material.dart';
import '../config/theme_extensions.dart';

/// 🎨 Adaptive Widgets for Light/Dark Theme Support
/// These widgets automatically adapt to the current theme

// ========== ADAPTIVE CONTAINER ==========
class AdaptiveContainer extends StatelessWidget {
  const AdaptiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation = 1.0,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.gradient,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final LinearGradient? gradient;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final decoration = gradient != null
        ? AppStyles.buildGradientDecoration(
            context,
            gradient: gradient!,
            borderRadius: borderRadius ?? context.radius.md,
            borderColor: borderColor,
            borderWidth: borderWidth,
          )
        : AppStyles.buildSurfaceDecoration(
            context,
            borderRadius: borderRadius ?? context.radius.md,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            elevation: elevation,
          );

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      constraints: constraints,
      alignment: alignment,
      decoration: decoration,
      child: child,
    );
  }
}

// ========== ADAPTIVE CARD ==========
class AdaptiveCard extends StatelessWidget {
  const AdaptiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation = 1.0,
    this.borderRadius,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final double? borderRadius;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final decoration = AppStyles.buildSurfaceDecoration(
      context,
      borderRadius: borderRadius ?? context.radius.lg,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      elevation: elevation,
    );

    final content = Container(
      margin: margin,
      padding: padding ?? EdgeInsets.all(context.spacing.md),
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? context.radius.lg),
        child: content,
      );
    }

    return content;
  }
}

// ========== ADAPTIVE TEXT ==========
class AdaptiveText extends StatelessWidget {
  const AdaptiveText(
    this.text, {
    super.key,
    this.style,
    this.lightColor,
    this.darkColor,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  final String text;
  final TextStyle? style;
  final Color? lightColor;
  final Color? darkColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    Color? adaptiveColor;
    if (lightColor != null && darkColor != null) {
      adaptiveColor = context.adaptiveColor(lightColor!, darkColor!);
    }

    return Text(
      text,
      style:
          style?.copyWith(color: adaptiveColor) ??
          TextStyle(color: adaptiveColor),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

// ========== ADAPTIVE ICON ==========
class AdaptiveIcon extends StatelessWidget {
  const AdaptiveIcon(
    this.icon, {
    super.key,
    this.size,
    this.lightColor,
    this.darkColor,
    this.semanticLabel,
    this.textDirection,
  });

  final IconData icon;
  final double? size;
  final Color? lightColor;
  final Color? darkColor;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    Color? adaptiveColor;
    if (lightColor != null && darkColor != null) {
      adaptiveColor = context.adaptiveColor(lightColor!, darkColor!);
    }

    return Icon(
      icon,
      size: size,
      color: adaptiveColor,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

// ========== STATUS BADGE ==========
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.text,
    required this.color,
    this.isOutlined = false,
    this.padding,
    this.textStyle,
  });

  final String text;
  final Color color;
  final bool isOutlined;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final decoration = AppStyles.buildStatusDecoration(
      context,
      color: color,
      isOutlined: isOutlined,
    );

    return Container(
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: context.spacing.sm,
            vertical: context.spacing.xs,
          ),
      decoration: decoration,
      child: Text(
        text,
        style:
            textStyle ??
            context.textTheme.labelSmall?.copyWith(
              color: isOutlined ? color : color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

// ========== GRADIENT BUTTON ==========
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.elevation = 2.0,
    this.width,
    this.height,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final LinearGradient? gradient;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double elevation;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ?? context.customColors.gradientPrimary;

    return Container(
      width: width,
      height: height ?? 48,
      decoration: AppStyles.buildGradientDecoration(
        context,
        gradient: effectiveGradient,
        borderRadius: borderRadius ?? context.radius.md,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(
            borderRadius ?? context.radius.md,
          ),
          child: Container(
            padding:
                padding ??
                EdgeInsets.symmetric(
                  horizontal: context.spacing.lg,
                  vertical: context.spacing.md,
                ),
            alignment: Alignment.center,
            child: DefaultTextStyle(
              style: context.textTheme.labelLarge!.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

// ========== THEME TOGGLE BUTTON ==========
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key, this.onPressed, this.size = 24.0});

  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkTheme;

    return IconButton(
      onPressed: onPressed,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(turns: animation, child: child);
        },
        child: Icon(
          isDark ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey(isDark),
          size: size,
          color: context.colorScheme.onSurface,
        ),
      ),
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
    );
  }
}

// ========== ADAPTIVE DIVIDER ==========
class AdaptiveDivider extends StatelessWidget {
  const AdaptiveDivider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness ?? 1.0,
      indent: indent,
      endIndent: endIndent,
      color: color ?? context.colorScheme.outline.withValues(alpha: 0.2),
    );
  }
}

// ========== ADAPTIVE SURFACE ==========
class AdaptiveSurface extends StatelessWidget {
  const AdaptiveSurface({
    super.key,
    required this.child,
    this.elevation = 0.0,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.clipBehavior = Clip.none,
  });

  final Widget child;
  final double elevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: context.colorScheme.surfaceContainerLow,
      shadowColor: shadowColor ?? context.colorScheme.shadow,
      surfaceTintColor: surfaceTintColor ?? context.colorScheme.surfaceTint,
      shape: shape,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

// ========== PRICE DISPLAY ==========
class PriceDisplay extends StatelessWidget {
  const PriceDisplay({
    super.key,
    required this.price,
    this.currency = 'Rp',
    this.style,
    this.showBackground = false,
    this.backgroundColor,
    this.textColor,
  });

  final double price;
  final String currency;
  final TextStyle? style;
  final bool showBackground;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
        '$currency ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

    final textWidget = Text(
      formattedPrice,
      style:
          style?.copyWith(
            color: textColor ?? context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ) ??
          context.textTheme.bodyMedium?.copyWith(
            color: textColor ?? context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
    );

    if (showBackground) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.sm,
          vertical: context.spacing.xs,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(context.radius.sm),
        ),
        child: textWidget,
      );
    }

    return textWidget;
  }
}
