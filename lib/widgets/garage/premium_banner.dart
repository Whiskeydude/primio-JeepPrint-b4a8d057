import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class PremiumBanner extends StatelessWidget {
  final VoidCallback onTap;

  const PremiumBanner({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    return Material(
      color: colors.primaryContainer,
      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: Row(
            children: [
              Icon(Icons.workspace_premium_rounded, size: AppTheme.iconLg, color: colors.onPrimaryContainer),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Unlock unlimited access',
                        style: text.titleMedium?.copyWith(color: colors.onPrimaryContainer)),
                    Text(
                      'All owner comments and STL downloads',
                      style: text.bodySmall?.copyWith(color: colors.onPrimaryContainer),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colors.onPrimaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}
