import 'package:flutter/material.dart';
import '../../../../shared/config/theme_extensions.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  const PasswordField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: !_visible,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan password Anda',
        prefixIcon: Icon(
          Icons.lock_outline,
          color: context.colorScheme.onSurfaceVariant,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _visible ? Icons.visibility_off : Icons.visibility,
            color: context.colorScheme.onSurfaceVariant,
          ),
          onPressed: () => setState(() => _visible = !_visible),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
          borderSide: BorderSide(color: context.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
          borderSide: BorderSide(color: context.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
          borderSide: BorderSide(color: context.colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
          borderSide: BorderSide(color: context.colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
          borderSide: BorderSide(color: context.colorScheme.error, width: 2),
        ),
        filled: true,
        fillColor: context.colorScheme.surface,
        labelStyle: TextStyle(color: context.colorScheme.onSurfaceVariant),
        hintStyle: TextStyle(
          color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        errorStyle: TextStyle(color: context.colorScheme.error),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
      onFieldSubmitted: (_) => widget.onSubmit(),
    );
  }
}
