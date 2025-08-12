import 'package:flutter/material.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';

class TotalsBlock extends StatelessWidget {
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .05),
        border: Border(
          top: BorderSide(color: theme.dividerColor.withOpacity(.5)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _totalRow(context, 'Total Item ', '$totalQty'),
          const SizedBox(height: 6),
          // _totalRow(context, 'Taxes', idrFormat(0)),
          // const SizedBox(height: 6),
          // _totalRow(context, 'Discount', '- ${idrFormat(0)}'),
          // const SizedBox(height: 12),
          // Divider(color: theme.dividerColor.withOpacity(.6)),
          // const SizedBox(height: 12),
          _totalRow(
            context,
            'Total Harga',
            idrFormat(totalPrice),
            strong: true,
            highlight: true,
          ),
          const SizedBox(height: 16),
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
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
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
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(.75),
            fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style:
              (highlight
                      ? theme.textTheme.titleLarge
                      : theme.textTheme.titleMedium)
                  ?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: highlight
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
                  ),
        ),
      ],
    );
  }
}
