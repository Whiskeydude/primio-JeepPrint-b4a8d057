import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../paywall/status_message.dart';

class AdminLoginForm extends StatefulWidget {
  final bool isBusy;
  final String? errorMessage;
  final void Function(String email, String password) onSubmit;

  const AdminLoginForm({
    super.key,
    required this.isBusy,
    required this.onSubmit,
    this.errorMessage,
  });

  @override
  State<AdminLoginForm> createState() => _AdminLoginFormState();
}

class _AdminLoginFormState extends State<AdminLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_usernameController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Administrator sign-in', style: text.headlineMedium),
          const SizedBox(height: AppTheme.spacingSm),
          Text('Sign in with the admin email and password.', style: text.bodyMedium),
          const SizedBox(height: AppTheme.spacingLg),
          TextFormField(
            controller: _usernameController,
            enabled: !widget.isBusy,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline)),
            validator: (v) => (v == null || !v.contains('@')) ? 'Enter the admin email' : null,
          ),
          const SizedBox(height: AppTheme.spacingMd),
          TextFormField(
            controller: _passwordController,
            enabled: !widget.isBusy,
            obscureText: _obscure,
            autocorrect: false,
            enableSuggestions: false,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                tooltip: _obscure ? 'Show password' : 'Hide password',
                icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
            validator: (v) => (v == null || v.isEmpty) ? 'Enter the password' : null,
          ),
          if (widget.errorMessage != null) ...[
            const SizedBox(height: AppTheme.spacingMd),
            StatusMessage(message: widget.errorMessage!, isError: true),
          ],
          const SizedBox(height: AppTheme.spacingLg),
          FilledButton(
            onPressed: widget.isBusy ? null : _submit,
            child: Text(widget.isBusy ? 'Please wait…' : 'Sign in'),
          ),
        ],
      ),
    );
  }
}
