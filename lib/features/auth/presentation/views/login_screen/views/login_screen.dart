import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/core/widgets/app_logo.dart';
import 'package:tafaling/core/widgets/app_text_input.dart';
import 'package:tafaling/core/widgets/network_error_dialog.dart';
import 'package:tafaling/features/auth/injection.dart';
import 'package:tafaling/features/auth/presentation/views/login_screen/bloc/login_screen_bloc.dart';

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
      create: (context) => sl<LoginScreenBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.theme.colorScheme.primary,
                context.theme.colorScheme.secondary,
              ],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          child: BlocListener<LoginScreenBloc, LoginScreenState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
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
                      AppLogo(width: 150, height: 150),
                      const SizedBox(height: 50),
                      BlocBuilder<LoginScreenBloc, LoginScreenState>(
                        builder: (context, state) {
                          return Column(
                            spacing: 10,
                            children: [
                              AppTextInput(
                                controller: usernameController,
                                label: 'Username',
                                errorText:
                                    state is LoginValidationErrorState
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
                                    state is LoginValidationErrorState
                                        ? state
                                                    .errors['password']
                                                    ?.isNotEmpty ==
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
                              if (state is LoginLoadingState)
                                CircularProgressIndicator(),
                              if (state is! LoginLoadingState)
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<LoginScreenBloc>().add(
                                      LoginEvent(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                          0.1,
                                      vertical: 10,
                                    ),
                                    backgroundColor: Colors.tealAccent,
                                  ),
                                  child: const Text('Login'),
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
      ),
    );
  }
}
