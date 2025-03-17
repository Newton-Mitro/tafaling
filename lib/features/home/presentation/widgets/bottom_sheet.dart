import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/core/widgets/app_logo.dart';
import 'package:tafaling/features/home/presentation/widgets/button_widget.dart';
import 'package:tafaling/features/home/presentation/widgets/close_button.dart';
import 'package:tafaling/features/post/presentation/posts_screen/bloc/posts_screen_bloc.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.theme.colorScheme.primary,
            context.theme.colorScheme.secondary
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CloseBottomSheetButton(),
          const SizedBox(height: 20),
          const AppLogo(width: 200),
          const SizedBox(height: 50),
          CustomButton(context, 'Login', RoutesName.loginPage),
          const SizedBox(height: 10),
          const Text('or',
              style: TextStyle(fontSize: 16, color: Colors.white70)),
          const SizedBox(height: 10),
          CustomButton(context, 'Register', RoutesName.registerPage),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return const CustomBottomSheet();
    },
  );
}
