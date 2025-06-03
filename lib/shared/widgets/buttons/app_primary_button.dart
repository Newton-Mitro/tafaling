import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? iconBefore;
  final Widget? iconAfter;
  final double horizontalPadding;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.iconBefore,
    this.iconAfter,
    this.horizontalPadding = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: theme.colorScheme.primary),
          ),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconBefore != null) ...[iconBefore!, const SizedBox(width: 8)],
            Text(label),
            if (iconAfter != null) ...[const SizedBox(width: 8), iconAfter!],
          ],
        ),
      ),
    );
  }
}
