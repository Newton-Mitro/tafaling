import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/core/widgets/app_logo.dart';
import 'package:tafaling/core/widgets/app_text_input.dart';
import 'package:tafaling/features/auth/presentation/states/login_bloc/login_screen_bloc.dart';
import 'package:tafaling/injection_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLoc<LoginScreenBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
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
          child: BlocListener<LoginScreenBloc, LoginScreenState>(
            listener: (context, state) {
              if (state is LoggedIn) {
                Navigator.pushReplacementNamed(context, RoutesName.homePage);
              }
              if (state is LoginError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppLogo(
                        width: 200,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<LoginScreenBloc, LoginScreenState>(
                        builder: (context, state) {
                          return Column(
                            spacing: 10,
                            children: [
                              AppTextInput(
                                controller: usernameController,
                                label: 'Username',
                                errorText: state is LoginValidationError
                                    ? state.errors['email']?.isNotEmpty == true
                                        ? state.errors['email']![0]
                                        : null
                                    : null,
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.white),
                              ),
                              AppTextInput(
                                controller: passwordController,
                                label: 'Password',
                                errorText: state is LoginValidationError
                                    ? state.errors['password']?.isNotEmpty ==
                                            true
                                        ? state.errors['password']![0]
                                        : null
                                    : null,
                                prefixIcon:
                                    const Icon(Icons.lock, color: Colors.white),
                                obscureText: !_isPasswordVisible,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (state is LoginLoading)
                                CircularProgressIndicator(),
                              if (state is! LoginLoading)
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<LoginScreenBloc>()
                                        .add(LoginEvent(
                                          usernameController.text,
                                          passwordController.text,
                                        ));
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
