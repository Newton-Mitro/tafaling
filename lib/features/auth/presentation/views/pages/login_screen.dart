import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/routes/app_route_name.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/shared/widgets/app_logo.dart';
import 'package:tafaling/shared/widgets/app_text_input.dart';
import 'package:tafaling/shared/widgets/buttons/app_primary_button.dart';
import 'package:tafaling/shared/widgets/network_error_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, AppRouteName.homePage);
            }

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
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogo(width: 150),
                    const SizedBox(height: 50),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Column(
                          spacing: 10,
                          children: [
                            AppTextInput(
                              controller: usernameController,
                              label: 'Username',
                              errorText:
                                  state is AuthValidationErrorState
                                      ? state.errors['email']?.isNotEmpty ==
                                              true
                                          ? state.errors['email']![0]
                                          : null
                                      : null,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            AppTextInput(
                              controller: passwordController,
                              label: 'Password',
                              errorText:
                                  state is AuthValidationErrorState
                                      ? state.errors['password']?.isNotEmpty ==
                                              true
                                          ? state.errors['password']![0]
                                          : null
                                      : null,
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            if (state is AuthLoading)
                              CircularProgressIndicator(),
                            if (state is! AuthLoading)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppPrimaryButton(
                                    label: "Login",
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                        LoginRequested(
                                          username: usernameController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
