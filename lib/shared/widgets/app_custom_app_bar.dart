import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/home/presentation/widgets/bottom_sheet.dart';
import 'package:tafaling/routes/app_route_name.dart';
import 'package:tafaling/shared/widgets/language_switch/language_switch.dart';
import 'package:tafaling/shared/widgets/theme_selector/theme_selector.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppCustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      elevation: 5,
      actions: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (state is Authenticated) {
                  Navigator.pushNamed(context, AppRouteName.searchUser);
                } else {
                  showCustomBottomSheet(context);
                }
              },
            );
          },
        ),
        const ThemeSelector(),
        const LanguageSwitch(),
        const SizedBox(width: 10),
      ],
    );
  }
}
