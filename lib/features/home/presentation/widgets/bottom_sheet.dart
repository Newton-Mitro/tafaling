import 'package:flutter/material.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/home/presentation/states/notifiers.dart';

class BottomSheetHelper {
  static void showCustomBottomSheet(BuildContext context, Size screenSize) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
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
            borderRadius: BorderRadius.only(
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
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/brand/logo.png',
                  width: 150,
                ),
              ),
              const SizedBox(height: 50),
              _buildButton(context, 'Login', RoutesName.loginPage, screenSize),
              const SizedBox(height: 10),
              const Text(
                'or',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 10),
              _buildButton(
                  context, 'Register', RoutesName.registerPage, screenSize),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    ).whenComplete(() {
      // Reset the flag when the bottom sheet is dismissed
      bottomSheetToggleNotifier.value = false;
    });
  }

  static Widget _buildButton(
      BuildContext context, String text, String route, Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.theme.colorScheme.surface,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18, color: context.theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}
