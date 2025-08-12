import 'dart:async';
import 'package:flutter/material.dart';

/// Reusable custom alert dialog.
/// Supports async confirm (showing a loading indicator) and simple styling.
class CustomAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final FutureOr<void> Function()? onConfirm;
  final VoidCallback? onCancel;
  final bool destructive;
  final bool dismissible;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelText = 'Cancel',
    this.confirmText = 'OK',
    this.onConfirm,
    this.onCancel,
    this.destructive = false,
    this.dismissible = true,
  });

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  bool _loading = false;

  Future<void> _handleConfirm() async {
    if (widget.onConfirm == null) {
      if (!mounted) return;
      Navigator.of(context).pop(true);
      return;
    }
    setState(() => _loading = true);
    try {
      await widget.onConfirm!();
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      // Optionally handle error or keep dialog open
      if (mounted) setState(() => _loading = false);
    }
  }

  void _handleCancel() {
    widget.onCancel?.call();
    if (mounted) Navigator.of(context).maybePop(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color confirmColor = widget.destructive
        ? theme.colorScheme.error
        : theme.colorScheme.primary;

    return WillPopScope(
      onWillPop: () async => widget.dismissible && !_loading,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(widget.content, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _loading ? null : _handleCancel,
                      child: Text(widget.cancelText),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _loading ? null : _handleConfirm,
                      style: FilledButton.styleFrom(
                        backgroundColor: confirmColor,
                        foregroundColor: theme.colorScheme.onPrimary,
                        minimumSize: const Size(88, 44),
                      ),
                      child: _loading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.onPrimary,
                                ),
                              ),
                            )
                          : Text(widget.confirmText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
