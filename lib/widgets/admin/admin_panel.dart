import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class AdminPanel extends StatelessWidget {
  final String email;
  final bool isBusy;
  final VoidCallback onSignOut;

  const AdminPanel({super.key, required this.email, required this.isBusy, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.verified_user_outlined, color: appColors.success),
        const SizedBox(height: AppTheme.spacingSm),
        Text('Signed in as $email', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          'Your Supabase admin account is connected. Admin tools will appear here once you decide what they should do.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: AppTheme.spacingLg),
        OutlinedButton.icon(
          onPressed: isBusy ? null : onSignOut,
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Sign out'),
        ),
      ],
    );
  }
}
