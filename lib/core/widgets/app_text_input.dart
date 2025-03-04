import 'package:flutter/material.dart';

class AppTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final Icon? prefixIcon;
  final bool obscureText;
  final IconButton? suffixIcon;
  final TextInputType keyboardType; // Added keyboardType property

  const AppTextInput({
    super.key,
    required this.controller,
    required this.label,
    this.errorText,
    this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text, // Default value
  });

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late ValueNotifier<bool> _obscureTextNotifier;

  @override
  void initState() {
    super.initState();
    _obscureTextNotifier = ValueNotifier<bool>(widget.obscureText);
  }

  @override
  void dispose() {
    _obscureTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: ValueListenableBuilder<bool>(
            valueListenable: _obscureTextNotifier,
            builder: (context, isObscured, child) {
              return TextField(
                controller: widget.controller,
                obscureText: isObscured,
                keyboardType: widget.keyboardType, // Added here
                decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: widget.prefixIcon,
                  filled: true,
                  fillColor: const Color(0xFF004C55).withOpacity(0.7),
                  hintStyle: const TextStyle(color: Colors.white54),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.teal, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  suffixIcon: widget.suffixIcon ??
                      (widget.obscureText
                          ? IconButton(
                              icon: Icon(
                                  isObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white),
                              onPressed: () {
                                _obscureTextNotifier.value = !isObscured;
                              },
                            )
                          : null),
                ),
                style: const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 1.0, left: 8),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
