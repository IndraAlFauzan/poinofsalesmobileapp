import 'package:flutter/material.dart';

/// Mixin untuk membuat widget responsive dan mencegah overflow
mixin ResponsiveMixin {
  /// Wrapper untuk Row yang aman dari overflow
  Widget safeRow({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    required List<Widget> children,
    EdgeInsets? padding,
    bool scrollable = false,
  }) {
    Widget row = Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) {
        // Auto-wrap Text widgets dengan Flexible
        if (child is Text) {
          return Flexible(child: child);
        }
        // Auto-wrap Buttons dengan Flexible jika diperlukan
        if (child is ElevatedButton ||
            child is FilledButton ||
            child is OutlinedButton ||
            child is TextButton) {
          return Flexible(child: child);
        }
        return child;
      }).toList(),
    );

    if (padding != null) {
      row = Padding(padding: padding, child: row);
    }

    if (scrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(child: row),
      );
    }

    return row;
  }

  /// Wrapper untuk Column yang aman dari overflow
  Widget safeColumn({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    required List<Widget> children,
    EdgeInsets? padding,
    bool scrollable = false,
  }) {
    Widget column = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );

    if (padding != null) {
      column = Padding(padding: padding, child: column);
    }

    if (scrollable) {
      return SingleChildScrollView(child: column);
    }

    return column;
  }

  /// Special method untuk text harga yang harus selalu terlihat penuh
  Widget priceText(
    String price, {
    TextStyle? style,
    BuildContext? context,
    TextAlign textAlign = TextAlign.start,
  }) {
    return responsiveText(
      price,
      style: style,
      context: context,
      textAlign: textAlign,
      preserveImportantText: true,
      maxLines: 1,
    );
  }

  /// Special method untuk text produk name yang boleh multi-line
  Widget productNameText(
    String name, {
    TextStyle? style,
    BuildContext? context,
    int maxLines = 2,
  }) {
    return responsiveText(
      name,
      style: style,
      context: context,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Helper untuk mendapatkan ukuran grid yang responsif
  double getResponsiveGridItemHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1200) return 280; // Desktop large
    if (width > 900) return 260; // Desktop medium
    if (width > 600) return 240; // Tablet landscape
    if (width > 400) return 220; // Tablet portrait
    return 200; // Mobile
  }

  /// Helper untuk mendapatkan cross axis count yang responsif
  int getResponsiveGridCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1200) return 5; // Desktop large
    if (width > 900) return 4; // Desktop medium
    if (width > 600) return 3; // Tablet landscape
    if (width > 400) return 2; // Tablet portrait
    return 2; // Mobile
  }

  /// Helper untuk mendapatkan ukuran font yang responsif
  double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1200) {
      return baseFontSize * 1.1; // Desktop large - sedikit lebih besar
    }
    if (width > 900) return baseFontSize; // Desktop medium - normal
    if (width > 600) return baseFontSize * 0.95; // Tablet - sedikit lebih kecil
    if (width > 400) return baseFontSize * 0.9; // Mobile large - lebih kecil
    return baseFontSize * 0.85; // Mobile small - paling kecil
  }

  /// Widget khusus untuk price text yang selalu visible
  Widget guaranteedPriceText(
    String price, {
    TextStyle? style,
    required BuildContext context,
    TextAlign textAlign = TextAlign.start,
  }) {
    final baseStyle = style ?? const TextStyle();

    return Text(
      price,
      style: baseStyle.copyWith(
        fontSize: getResponsiveFontSize(context, baseStyle.fontSize ?? 14),
      ),
      textAlign: textAlign,
      maxLines: 1,
      overflow: TextOverflow.visible,
      softWrap: false,
    );
  }

  /// Text yang responsive dengan auto font scaling
  Widget responsiveText(
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign textAlign = TextAlign.start,
    BuildContext? context,
    bool preserveImportantText =
        false, // New parameter for important text like prices
  }) {
    TextStyle? adaptedStyle = style;

    if (context != null && style != null) {
      final screenWidth = MediaQuery.of(context).size.width;
      double fontMultiplier = 1.0;

      // More aggressive font scaling for important text to ensure visibility
      if (preserveImportantText) {
        if (screenWidth < 600) {
          fontMultiplier = 0.85; // Smaller but still readable
        } else if (screenWidth < 400) {
          fontMultiplier = 0.75; // Much smaller for very small screens
        } else if (screenWidth < 350) {
          fontMultiplier = 0.7; // Very small screens
        }
      } else {
        if (screenWidth < 600) {
          fontMultiplier = 0.95;
        } else if (screenWidth < 400) {
          fontMultiplier = 0.9;
        }
      }

      adaptedStyle = style.copyWith(
        fontSize: (style.fontSize ?? 14) * fontMultiplier,
      );
    }

    // For important text, prefer wrapping over ellipsis
    TextOverflow finalOverflow = overflow;
    int? finalMaxLines = maxLines;

    if (preserveImportantText) {
      finalOverflow = TextOverflow.visible; // Show full text
      finalMaxLines = null; // Allow multiple lines if needed
    }

    return Text(
      text,
      style: adaptedStyle,
      maxLines: finalMaxLines,
      overflow: finalOverflow,
      textAlign: textAlign,
    );
  }

  /// Container dengan constraints yang aman
  Widget safeContainer({
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Decoration? decoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      width: width,
      height: height,
      alignment: alignment,
      constraints:
          constraints ?? const BoxConstraints(minWidth: 0, minHeight: 0),
      child: child,
    );
  }

  /// Button yang responsive
  Widget responsiveButton({
    required VoidCallback? onPressed,
    required Widget child,
    ButtonStyle? style,
    BuildContext? context,
    bool isIcon = false,
  }) {
    ButtonStyle adaptedStyle = style ?? FilledButton.styleFrom();

    if (context != null) {
      final screenWidth = MediaQuery.of(context).size.width;
      EdgeInsets padding = const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      );

      if (screenWidth < 600) {
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      } else if (screenWidth < 400) {
        padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      }

      adaptedStyle = adaptedStyle.copyWith(
        padding: WidgetStateProperty.all(padding),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    if (isIcon) {
      return FilledButton.icon(
        onPressed: onPressed,
        style: adaptedStyle,
        icon: const Icon(Icons.add, size: 16),
        label: child,
      );
    }

    return FilledButton(
      onPressed: onPressed,
      style: adaptedStyle,
      child: child,
    );
  }

  /// Responsive spacing
  double responsiveSpacing(BuildContext context, {double base = 16.0}) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return base * 0.75;
    } else if (screenWidth < 400) {
      return base * 0.5;
    }

    return base;
  }

  /// Safe ListView.builder dengan overflow protection
  Widget safeListView({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    Widget Function(BuildContext, int)? separatorBuilder,
  }) {
    if (separatorBuilder != null) {
      return ListView.separated(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        scrollDirection: scrollDirection,
        padding: padding,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
      );
    }

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }
}

/// Extension untuk semua Widget
extension ResponsiveWidgetExtension on Widget {
  /// Membuat widget menjadi flexible
  Widget get flex => Flexible(child: this);

  /// Membuat widget menjadi expanded
  Widget get expand => Expanded(child: this);

  /// Wrap dengan SafeArea
  Widget get safe => SafeArea(child: this);

  /// Wrap dengan SingleChildScrollView
  Widget get scrollable => SingleChildScrollView(child: this);

  /// Wrap dengan Center
  Widget get center => Center(child: this);

  /// Responsive padding berdasarkan screen size
  Widget responsivePadding(BuildContext context, {double multiplier = 1.0}) {
    final screenWidth = MediaQuery.of(context).size.width;
    double padding = 16.0 * multiplier;

    if (screenWidth < 600) {
      padding = 12.0 * multiplier;
    } else if (screenWidth < 400) {
      padding = 8.0 * multiplier;
    }

    return Padding(padding: EdgeInsets.all(padding), child: this);
  }
}
