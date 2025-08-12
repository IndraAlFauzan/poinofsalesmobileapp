import 'package:flutter/material.dart';

class EmptyCartHint extends StatelessWidget {
  const EmptyCartHint({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          "Keranjang kosong. Tambahkan item sekarang!",
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(.6),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
