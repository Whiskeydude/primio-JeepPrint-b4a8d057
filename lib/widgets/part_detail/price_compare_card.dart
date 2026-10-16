import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/theme.dart';

class PriceCompareCard extends StatelessWidget {
  final double dealerPrice;
  final double printPrice;
  final int savingsPercent;

  const PriceCompareCard({
    super.key,
    required this.dealerPrice,
    required this.printPrice,
    required this.savingsPercent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;
    final money = NumberFormat.simpleCurrency(name: 'USD');

    Widget column(String label, String value, Color color) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: text.labelMedium),
              const SizedBox(height: AppTheme.spacingXs),
              Text(value, style: text.headlineMedium?.copyWith(color: color)),
            ],
          ),
        );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                column('Dealer part', money.format(dealerPrice), colors.onSurfaceVariant),
                column('Printed (est.)', money.format(printPrice), appColors.success),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
              child: LinearProgressIndicator(
                value: printPrice / dealerPrice,
                minHeight: AppTheme.spacingSm,
                backgroundColor: colors.surfaceContainerHighest,
                color: appColors.success,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Text(
              'You save ${money.format(dealerPrice - printPrice)} ($savingsPercent%)',
              style: text.titleMedium?.copyWith(color: appColors.success),
            ),
          ],
        ),
      ),
    );
  }
}
