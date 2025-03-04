import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/widgets/language_selector/bloc/language_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
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
            context
                .read<LanguageBloc>()
                .add(LanguageSelected(language: value == 0 ? 'en' : 'bn'));
          },
          initialValue: state.language == 'en'
              ? 0
              : state.language == 'bn'
                  ? 1
                  : 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 5),
                Text(state.language),
              ],
            ),
          ),
        );
      },
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
