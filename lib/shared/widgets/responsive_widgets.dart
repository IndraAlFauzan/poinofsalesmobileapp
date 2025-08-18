import 'package:flutter/material.dart';

/// Utility widget untuk mencegah overflow dengan responsive design
class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final EdgeInsets? padding;
  final bool wrapIfNeeded;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.padding,
    this.wrapIfNeeded = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget rowWidget = Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) {
        // Wrap text widgets dengan Flexible untuk mencegah overflow
        if (child is Text) {
          return Flexible(child: child);
        }
        return child;
      }).toList(),
    );

    if (padding != null) {
      rowWidget = Padding(padding: padding!, child: rowWidget);
    }

    // Wrap dengan SingleChildScrollView jika diperlukan
    if (wrapIfNeeded) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(child: rowWidget),
      );
    }

    return rowWidget;
  }
}

/// Utility widget untuk Column yang responsive
class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final EdgeInsets? padding;

  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget columnWidget = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) {
        // Wrap dengan Flexible jika diperlukan untuk mencegah overflow
        if (child is Container || child is Card || child is Column) {
          return Flexible(child: child);
        }
        return child;
      }).toList(),
    );

    if (padding != null) {
      columnWidget = Padding(padding: padding!, child: columnWidget);
    }

    return columnWidget;
  }
}

/// Widget untuk text yang auto-responsive
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final bool adaptiveSize;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.adaptiveSize = true,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? adaptedStyle = style;

    if (adaptiveSize && style != null) {
      // Reduce font size for smaller screens
      final screenWidth = MediaQuery.of(context).size.width;
      double fontSizeMultiplier = 1.0;

      if (screenWidth < 600) {
        fontSizeMultiplier = 0.9;
      } else if (screenWidth < 400) {
        fontSizeMultiplier = 0.8;
      }

      adaptedStyle = style!.copyWith(
        fontSize: (style!.fontSize ?? 14) * fontSizeMultiplier,
      );
    }

    return Text(
      text,
      style: adaptedStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

/// Extension untuk membuat widget lebih responsive
extension ResponsiveWidgetExtensions on Widget {
  Widget get flexible => Flexible(child: this);
  Widget get expanded => Expanded(child: this);

  Widget withResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = 16.0;

    if (screenWidth < 600) {
      paddingValue = 12.0;
    } else if (screenWidth < 400) {
      paddingValue = 8.0;
    }

    return Padding(padding: EdgeInsets.all(paddingValue), child: this);
  }
}
