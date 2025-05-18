import 'package:flutter/material.dart';

class AppErrorButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Widget? iconBefore;
  final Widget? iconAfter;
  final double horizontalPadding;

  const AppErrorButton({
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 36,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: theme.colorScheme.primary),
              ),
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconBefore != null) ...[
                    iconBefore!,
                    const SizedBox(width: 8),
                  ],
                  Text(label),
                  if (iconAfter != null) ...[
                    const SizedBox(width: 8),
                    iconAfter!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
