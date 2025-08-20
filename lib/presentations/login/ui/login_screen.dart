import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';
import 'package:posmobile/shared/widgets/adaptive_widgets.dart';
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
  bool _isNavigating = false; // Add flag to prevent double navigation

  @override
  void initState() {
    super.initState();
    // Reset navigation flag when entering login screen
    _isNavigating = false;
    // Add listeners to update UI when text changes
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_isNavigating) return; // Prevent multiple submissions

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
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            state.whenOrNull(
              initial: () {
                // Reset navigation flag when returning to initial state
                if (_isNavigating) {
                  setState(() => _isNavigating = false);
                }
              },
              success: (data) {
                if (_isNavigating) return; // Prevent double navigation
                setState(() => _isNavigating = true);

                _showFlushbar(
                  title: 'Sukses',
                  message: data.message,
                  color: context.colorScheme.primary,
                );

                Future.delayed(const Duration(milliseconds: 2000), () {
                  if (context.mounted && _isNavigating) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainPage()),
                    );
                    _emailController.clear();
                    _passwordController.clear();
                  }
                });
              },
              failure: (message) {
                setState(() => _isNavigating = false); // Reset on failure
                _showFlushbar(
                  title: 'Gagal',
                  message: message,
                  color: context.colorScheme.error,
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

                // FORM CONTENT
                final form = Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: AdaptiveCard(
                      padding: EdgeInsets.all(context.spacing.xl),
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const LoginHeader(),
                          SizedBox(height: context.spacing.xxl),
                          EmailField(
                            controller: _emailController,
                            onSubmit: _submit,
                          ),
                          SizedBox(height: context.spacing.md),
                          PasswordField(
                            controller: _passwordController,
                            onSubmit: _submit,
                          ),
                          SizedBox(height: context.spacing.lg),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              final isLoading = state.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
                              );

                              final hasData =
                                  _emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty;

                              final isButtonEnabled =
                                  hasData && !_isNavigating && !isLoading;

                              return isButtonEnabled
                                  ? LoginButton(
                                      isLoading: isLoading,
                                      onPressed: _submit,
                                    )
                                  : ElevatedButton(
                                      onPressed: null,
                                      child: Text(
                                        _isNavigating
                                            ? "Berhasil..."
                                            : isLoading
                                            ? "Loading..."
                                            : "Login",
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                if (!isWide) {
                  // Mobile layout
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(context.spacing.xl),
                    child: form,
                  );
                }

                // Wide layout with side image
                return SingleChildScrollView(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: AdaptiveContainer(
                            padding: EdgeInsets.all(context.spacing.xl),
                            gradient: context.customColors.gradientPrimary,
                            borderRadius: context.radius.xl,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Kasir Warung Seblak',
                                  style: context.textTheme.headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                ),
                                SizedBox(height: context.spacing.xl),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: double.infinity,
                                    maxHeight: 400,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      context.radius.lg,
                                    ),
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
                      ),
                      SizedBox(width: context.spacing.xl),
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(context.spacing.xl),
                          child: form,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
