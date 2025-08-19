import 'package:flutter/material.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search menu…',
        prefixIcon: Icon(
          Icons.search,
          color: context.colorScheme.onSurfaceVariant,
        ),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
        filled: true,
        fillColor: context.colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
          borderSide: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
          borderSide: BorderSide(color: context.colorScheme.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: context.spacing.md,
          horizontal: context.spacing.md,
        ),
      ),
    );
  }
}
