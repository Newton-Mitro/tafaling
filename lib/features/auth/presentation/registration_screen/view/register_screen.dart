import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/core/widgets/app_logo.dart';
import 'package:tafaling/core/widgets/app_text_input.dart';
import 'package:tafaling/features/auth/presentation/registration_screen/bloc/signup_screen_bloc.dart';
import 'package:tafaling/injection_container.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLoc<SignUpScreenBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Register",
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.theme.colorScheme.primary,
                context.theme.colorScheme.secondary
              ],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          child: BlocListener<SignUpScreenBloc, SignUpScreenState>(
            listener: (context, state) {
              if (state is SignedUp) {
                Navigator.pushReplacementNamed(context, RoutesName.homePage);
              }
              if (state is SignUpError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }

              if (state is RegisteredCompleted) {
                Navigator.pushReplacementNamed(context, RoutesName.homePage);
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: BlocBuilder<SignUpScreenBloc, SignUpScreenState>(
                    builder: (context, state) {
                      return Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppLogo(
                            width: 200,
                          ),
                          const SizedBox(height: 20),
                          AppTextInput(
                            controller: nameController,
                            label: 'Name',
                            errorText: state is SignUpValidationError
                                ? state.errors['name']?.isNotEmpty == true
                                    ? state.errors['name']![0]
                                    : null
                                : null,
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                          AppTextInput(
                            controller: emailController,
                            label: 'Email',
                            errorText: state is SignUpValidationError
                                ? state.errors['email']?.isNotEmpty == true
                                    ? state.errors['email']![0]
                                    : null
                                : null,
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          AppTextInput(
                            controller: passwordController,
                            label: 'Password',
                            errorText: state is SignUpValidationError
                                ? state.errors['password']?.isNotEmpty == true
                                    ? state.errors['password']![0]
                                    : null
                                : null,
                            obscureText: _obscurePassword,
                          ),
                          AppTextInput(
                            controller: confirmPasswordController,
                            label: 'Confirm Password',
                            errorText: state is SignUpValidationError
                                ? state.errors['confirm_password']
                                            ?.isNotEmpty ==
                                        true
                                    ? state.errors['confirm_password']![0]
                                    : null
                                : null,
                            obscureText: _obscureConfirmPassword,
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<SignUpScreenBloc, SignUpScreenState>(
                            builder: (context, state) {
                              if (state is SignUpLoading) {
                                return CircularProgressIndicator();
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<SignUpScreenBloc>()
                                      .add(RegisterEvent(
                                        nameController.text,
                                        passwordController.text,
                                        emailController.text,
                                        confirmPasswordController.text,
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  backgroundColor: Colors.tealAccent,
                                ),
                                child: const Text('Register'),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
