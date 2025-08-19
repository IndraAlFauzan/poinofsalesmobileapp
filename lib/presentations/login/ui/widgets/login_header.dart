import 'package:flutter/material.dart';
import '../../../../shared/config/theme_extensions.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Logo/Icon
        Container(
          padding: EdgeInsets.all(context.spacing.md),
          decoration: BoxDecoration(
            gradient: context.customColors.gradientPrimary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.restaurant_menu_rounded,
            size: 48,
            color: Colors.white,
          ),
        ),
        SizedBox(height: context.spacing.lg),

        Text(
          'Selamat Datang!',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: context.spacing.sm),
        Text(
          'Silakan masuk untuk melanjutkan',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
