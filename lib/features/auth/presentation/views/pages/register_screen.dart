import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/routes/route_name.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/shared/widgets/app_logo.dart';
import 'package:tafaling/shared/widgets/app_text_input.dart';
import 'package:tafaling/shared/widgets/buttons/app_primary_button.dart';
import 'package:tafaling/shared/widgets/network_error_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );
  final TextEditingController confirmPasswordController = TextEditingController(
    text: '',
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              if (state.message == "No internet connection") {
                NetworkErrorDialog.show(context);
              } else {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'On Snap!',
                    message: state.message,

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            }

            if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, RoutesName.homePage);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Column(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppLogo(width: 150),
                        const SizedBox(height: 50),
                        AppTextInput(
                          controller: nameController,
                          label: 'Name',
                          errorText:
                              state is AuthValidationErrorState
                                  ? state.errors['name']?.isNotEmpty == true
                                      ? state.errors['name']![0]
                                      : null
                                  : null,
                          prefixIcon: Icon(Icons.person),
                        ),
                        AppTextInput(
                          controller: emailController,
                          label: 'Email',
                          errorText:
                              state is AuthValidationErrorState
                                  ? state.errors['email']?.isNotEmpty == true
                                      ? state.errors['email']![0]
                                      : null
                                  : null,
                          prefixIcon: Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        AppTextInput(
                          controller: passwordController,
                          label: 'Password',
                          errorText:
                              state is AuthValidationErrorState
                                  ? state.errors['password']?.isNotEmpty == true
                                      ? state.errors['password']![0]
                                      : null
                                  : null,
                          obscureText: true,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                        AppTextInput(
                          controller: confirmPasswordController,
                          label: 'Confirm Password',
                          errorText:
                              state is AuthValidationErrorState
                                  ? state
                                              .errors['confirm_password']
                                              ?.isNotEmpty ==
                                          true
                                      ? state.errors['confirm_password']![0]
                                      : null
                                  : null,
                          obscureText: true,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return CircularProgressIndicator();
                            }

                            return AppPrimaryButton(
                              label: "Register",
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  RegisterRequested(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                  ),
                                );
                              },
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
    );
  }
}
