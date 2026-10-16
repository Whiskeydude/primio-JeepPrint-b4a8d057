import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class PaywallHeader extends StatelessWidget {
  const PaywallHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          decoration: BoxDecoration(color: colors.primaryContainer, shape: BoxShape.circle),
          child: Icon(Icons.workspace_premium_rounded, size: AppTheme.iconXl, color: colors.onPrimaryContainer),
        ),
        const SizedBox(height: AppTheme.spacingMd),
        Text('Unlimited access', style: text.headlineLarge, textAlign: TextAlign.center),
        const SizedBox(height: AppTheme.spacingXs),
        Text(
          'Unlock every owner comment and print-ready file for your Jeep.',
          style: text.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
