import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class LockedSection extends StatelessWidget {
  final int hiddenComments;
  final VoidCallback onUnlock;

  const LockedSection({super.key, required this.hiddenComments, required this.onUnlock});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    final moreComments = hiddenComments > 0
        ? '$hiddenComments more owner comments and the print-ready STL file are'
        : 'The print-ready STL file is';
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.lock_rounded, color: colors.onPrimaryContainer),
              const SizedBox(width: AppTheme.spacingSm),
              Expanded(
                child: Text('Part of unlimited access', style: text.titleLarge?.copyWith(color: colors.onPrimaryContainer)),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            '$moreComments included with a one-time unlock.',
            style: text.bodyMedium?.copyWith(color: colors.onPrimaryContainer),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          FilledButton.icon(
            onPressed: onUnlock,
            icon: const Icon(Icons.lock_open_rounded),
            label: const Text('Unlock unlimited access'),
          ),
        ],
      ),
    );
  }
}
