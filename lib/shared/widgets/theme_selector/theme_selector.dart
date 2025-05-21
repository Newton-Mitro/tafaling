import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ThemeSelectorEvent>(
      color: context.theme.colorScheme.primary,
      offset: const Offset(0, 52),
      icon: Icon(Icons.color_lens, color: context.theme.colorScheme.onPrimary),
      tooltip: 'Select Theme',
      onSelected: (event) {
        context.read<ThemeSelectorBloc>().add(event);
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: SetPrimaryLightTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 18,
                    color: context.theme.colorScheme.onPrimary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Primary Light',
                    style: TextStyle(
                      color: context.theme.colorScheme.onPrimary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: SetPrimaryDarkTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 18,
                    color: context.theme.colorScheme.onPrimary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Primary Dark',
                    style: TextStyle(
                      color: context.theme.colorScheme.onPrimary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: SetForeverGreenLightTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 18,
                    color: context.theme.colorScheme.onPrimary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Forever Green',
                    style: TextStyle(
                      color: context.theme.colorScheme.onPrimary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
    );
  }
}
