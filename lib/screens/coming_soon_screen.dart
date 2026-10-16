import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/responsive_layout.dart';
import '../theme/theme.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;
  final String description;

  const ComingSoonScreen({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              children: [
                const SizedBox(height: AppTheme.spacingXl),
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingLg),
                  decoration: BoxDecoration(color: colors.primaryContainer, shape: BoxShape.circle),
                  child: Icon(Icons.construction_rounded, size: AppTheme.iconXl, color: colors.onPrimaryContainer),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                Text(title, style: theme.textTheme.headlineLarge, textAlign: TextAlign.center),
                const SizedBox(height: AppTheme.spacingSm),
                Text(description,
                    style: theme.textTheme.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
                    textAlign: TextAlign.center),
                const SizedBox(height: AppTheme.spacingSm),
                Text('We are building this in the workshop right now.',
                    style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
                const SizedBox(height: AppTheme.spacingXl),
                FilledButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Back to my Jeep'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
