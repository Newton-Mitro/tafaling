import 'package:flutter/material.dart';

class StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onPressed;

  const StatColumn({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Makes the background of InkWell transparent
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(
            8.0), // Optional: adds rounded corners to ripple

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
