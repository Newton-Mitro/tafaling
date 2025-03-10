import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';

class TopNavigation extends StatelessWidget {
  const TopNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 10,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            color: context.theme.colorScheme.onSurface,
            onPressed: () {},
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "For You",
              style: TextStyle(
                color: context.theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
