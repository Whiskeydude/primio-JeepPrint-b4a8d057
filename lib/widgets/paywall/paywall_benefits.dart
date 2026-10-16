import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class PaywallBenefits extends StatelessWidget {
  final List<String> benefits;

  const PaywallBenefits({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        for (final benefit in benefits)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingXs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_rounded, size: AppTheme.iconMd, color: theme.colorScheme.primary),
                const SizedBox(width: AppTheme.spacingSm + 4),
                Expanded(child: Text(benefit, style: theme.textTheme.bodyLarge)),
              ],
            ),
          ),
      ],
    );
  }
}
