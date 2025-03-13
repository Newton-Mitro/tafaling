import 'package:flutter/material.dart';

class CloseBottomSheetButton extends StatelessWidget {
  const CloseBottomSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
