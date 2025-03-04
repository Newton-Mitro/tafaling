import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/widgets/app_logo.dart';
import 'package:tafaling/core/widgets/app_text_input.dart';
import 'package:tafaling/injection_container.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF002b35),
              Color(0xFF015266),
            ],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  AppLogo(
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  AppTextInput(
                    controller: nameController,
                    label: 'Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  AppTextInput(
                    controller: emailController,
                    label: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AppTextInput(
                    controller: passwordController,
                    label: 'Password',
                    obscureText: _obscurePassword,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                  AppTextInput(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    obscureText: _obscureConfirmPassword,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: Colors.tealAccent,
                    ),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
