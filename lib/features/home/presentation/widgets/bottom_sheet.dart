import 'package:flutter/material.dart';
import 'package:tafaling/routes/app_route_name.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/shared/widgets/app_logo.dart';
import 'package:tafaling/features/home/presentation/widgets/button_widget.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,

      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: context.theme.colorScheme.onSurface,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const AppLogo(width: 100),
          const SizedBox(height: 50),
          CustomButton(context, 'Login', AppRouteName.loginPage),
          const SizedBox(height: 10),
          const Text(
            'or',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 10),
          CustomButton(context, 'Register', AppRouteName.registerPage),
          const SizedBox(height: 50),
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
