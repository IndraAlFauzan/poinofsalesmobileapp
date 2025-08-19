import 'package:flutter/material.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/mixins/responsive_mixin.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class TotalsBlock extends StatelessWidget with ResponsiveMixin {
  final int totalQty;
  final double totalPrice;
  final VoidCallback? onPay;

  const TotalsBlock({
    super.key,
    required this.totalQty,
    required this.totalPrice,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.spacing.lg,
        context.spacing.md,
        context.spacing.lg,
        context.spacing.lg,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(alpha: 0.1),
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _totalRow(context, 'Total Item ', '$totalQty'),
          SizedBox(height: context.spacing.xs),
          _totalRow(
            context,
            'Total Harga',
            idrFormat(totalPrice),
            strong: true,
            highlight: true,
          ),
          SizedBox(height: context.spacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPay,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Confirm Payment',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalRow(
    BuildContext context,
    String label,
    String value, {
    bool strong = false,
    bool highlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.75),
            fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        priceText(
          value,
          style:
              (highlight
                      ? context.textTheme.titleLarge
                      : context.textTheme.titleMedium)
                  ?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: highlight
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurface,
                  ),
          context: context,
        ),
      ],
    );
  }
}
