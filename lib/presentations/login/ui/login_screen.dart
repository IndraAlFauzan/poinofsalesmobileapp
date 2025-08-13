import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/presentations/dashboard/main_page.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/data/model/request/login_model_request.dart';
import 'widgets/login_header.dart';
import 'widgets/email_field.dart';
import 'widgets/password_field.dart';
import 'widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      context.read<LoginBloc>().add(
        LoginEvent.pressed(
          req: LoginModelRequest(email: email, password: password),
        ),
      );
    }
  }

  void _showFlushbar({
    required String title,
    required String message,
    required Color color,
  }) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      textDirection: Directionality.of(context),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: color,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (data) {
                _showFlushbar(
                  title: 'Sukses',
                  message: data.message,
                  color: Colors.green.shade400,
                );

                Future.delayed(const Duration(milliseconds: 2000), () {
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainPage()),
                    );
                    _emailController.clear();
                    _passwordController.clear();
                  }
                });
              },
              failure: (message) {
                _showFlushbar(
                  title: 'Gagal',
                  message: message,
                  color: Colors.red.shade400,
                );
                // Delay clearing error to allow UI to show message if needed
                Future.microtask(() {
                  if (!context.mounted) return;
                  context.read<LoginBloc>().add(const LoginEvent.clearError());
                });
              },
            );
          },
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;
                // FORM CONTENT (reuse)
                final form = Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const LoginHeader(),
                        const SizedBox(height: 48),
                        EmailField(
                          controller: _emailController,
                          onSubmit: _submit,
                        ),
                        const SizedBox(height: 16),
                        PasswordField(
                          controller: _passwordController,
                          onSubmit: _submit,
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            final isLoading = state.maybeWhen(
                              loading: () => true,
                              orElse: () => false,
                            );
                            return LoginButton(
                              isLoading: isLoading,
                              onPressed: _submit,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );

                if (!isWide) {
                  // Mobile layout (single column, optional hide image or place on top)
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: form,
                  );
                }

                // Wide layout with side image
                return Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Kasir Warung Seblak',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryLight,
                              ),
                            ),
                            const SizedBox(height: 32),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: double.infinity,
                                maxHeight: 400,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/login_image.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: form,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
