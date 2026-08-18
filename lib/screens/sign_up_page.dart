import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quick_nav/flutter_quick_nav.dart';

import '../widgets/language_button.dart';
import 'shopping_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    Widget? suffixIcon,
  }) {
    final colors = Theme.of(context).colorScheme;

    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
      labelStyle: TextStyle(fontSize: 17, color: colors.primary),
      floatingLabelStyle: TextStyle(
        fontSize: 17,
        color: colors.primary,
        fontWeight: FontWeight.w600,
      ),
      suffixIcon: suffixIcon,
      suffixIconColor: colors.primary,
      filled: true,
      fillColor: colors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: colors.primary.withValues(alpha: 0.35)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return context.tr('fieldRequired');
    if (!RegExp(r'^[A-Z\u0600-\u06FF]').hasMatch(name)) {
      return context.tr('nameCapitalError');
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return context.tr('fieldRequired');
    if (!email.contains('@')) return context.tr('emailError');
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return context.tr('fieldRequired');
    if (value.length < 6) return context.tr('passwordLengthError');
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return context.tr('fieldRequired');
    if (value != _passwordController.text) {
      return context.tr('passwordMismatchError');
    }
    return null;
  }

  Future<void> _createAccount() async {
    FocusScope.of(context).unfocus();
    // Only show the success dialog when every field is valid.
    if (!_formKey.currentState!.validate()) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          icon: Icon(
            Icons.check_circle,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            context.tr('accountCreated'),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          actions: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(context.tr('continueButton')),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    FlutterQuickNav.push(
      context,
      const ShoppingScreen(),
      type: TransitionType.fade,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAF8),
      appBar: AppBar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        title: Text(context.tr('signUpTitle')),
        actions: const [LanguageButton()],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth < 600 ? 24 : 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    key: const Key('fullNameField'),
                    controller: _nameController,
                    validator: _validateName,
                    decoration: _inputDecoration(
                      label: context.tr('fullNameLabel'),
                      hint: context.tr('fullNameHint'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('emailField'),
                    controller: _emailController,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration(
                      label: context.tr('emailLabel'),
                      hint: context.tr('emailHint'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('passwordField'),
                    controller: _passwordController,
                    validator: _validatePassword,
                    obscureText: !_isPasswordVisible,
                    decoration: _inputDecoration(
                      label: context.tr('passwordLabel'),
                      suffixIcon: IconButton(
                        tooltip: context.tr(
                          _isPasswordVisible
                              ? 'hidePasswordTooltip'
                              : 'showPasswordTooltip',
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('confirmPasswordField'),
                    controller: _confirmPasswordController,
                    validator: _validateConfirmPassword,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: _inputDecoration(
                      label: context.tr('confirmPasswordLabel'),
                      suffixIcon: IconButton(
                        tooltip: context.tr(
                          _isConfirmPasswordVisible
                              ? 'hidePasswordTooltip'
                              : 'showPasswordTooltip',
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    key: const Key('createAccountButton'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _createAccount,
                    child: Text(context.tr('createAccount')),
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
