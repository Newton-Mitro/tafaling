import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/utils/app_context.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: PopupLanguageSelectorItem(
              language: 'English',
              flagCode: FlagsCode.US,
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: PopupLanguageSelectorItem(
              language: 'বাংলা',
              flagCode: FlagsCode.BD,
            ),
          ),
        ];
      },
      onSelected: (int value) {
        Locale newLocale =
            (value == 0) ? const Locale('en') : const Locale('bn');
        // You should implement the locale-changing logic, such as updating the App's locale provider
      },
      initialValue:
          context.appLocalizations.localeName.startsWith('en') ? 0 : 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.language),
            const SizedBox(width: 5),
            Text(context.appLocalizations.localeName),
          ],
        ),
      ),
    );
  }
}

class PopupLanguageSelectorItem extends StatelessWidget {
  const PopupLanguageSelectorItem({
    super.key,
    required this.language,
    required this.flagCode,
  });

  final String language;
  final FlagsCode flagCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language),
        Flag.fromCode(
          flagCode,
          width: 20,
          height: 20,
        ),
      ],
    );
  }
}
