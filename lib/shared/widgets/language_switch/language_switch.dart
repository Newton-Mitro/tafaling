import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/shared/widgets/language_switch/bloc/language_switch_bloc.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageSwitchBloc, LanguageSwitchState>(
      builder: (context, state) {
        final isEnglish = state.language == 'en';

        return GestureDetector(
          onTap: () {
            context.read<LanguageSwitchBloc>().add(
              SwitchLanguage(language: isEnglish ? 'bn' : 'en'),
            );
          },
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: context.theme.colorScheme.surface,
              border: Border.all(
                color: context.theme.colorScheme.primary,
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                // Rectangular thumb
                AnimatedAlign(
                  alignment:
                      isEnglish ? Alignment.centerLeft : Alignment.centerRight,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 28,
                    height: 30,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(),
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                ),
                // "ENG" text
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'EN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              isEnglish
                                  ? context.theme.colorScheme.onPrimary
                                  : context.theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
                // "বাংলা" text
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'BN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              isEnglish
                                  ? context.theme.colorScheme.onSurface
                                  : context.theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
