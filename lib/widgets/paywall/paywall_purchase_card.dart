import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'status_message.dart';

class PaywallPurchaseCard extends StatelessWidget {
  final bool isPremium;
  final bool isStoreSupported;
  final bool isLoading;
  final bool isBusy;
  final bool isPending;
  final String? price;
  final String? productError;
  final String? errorMessage;
  final String? noticeMessage;
  final VoidCallback onBuy;
  final VoidCallback onRestore;
  final VoidCallback onRetry;
  final VoidCallback onDone;

  const PaywallPurchaseCard({
    super.key,
    required this.isPremium,
    required this.isStoreSupported,
    required this.isLoading,
    required this.isBusy,
    required this.isPending,
    required this.price,
    required this.productError,
    required this.errorMessage,
    required this.noticeMessage,
    required this.onBuy,
    required this.onRestore,
    required this.onRetry,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;
    final canBuy = isStoreSupported && price != null && !isBusy && !isPending;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isPremium) ...[
            Row(
              children: [
                Icon(Icons.check_circle_rounded, color: appColors.success),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(child: Text('You have unlimited access.', style: text.titleMedium)),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            FilledButton(onPressed: onDone, child: const Text('Back to parts')),
          ] else ...[
            Text('ONE-TIME PAYMENT', style: text.labelMedium, textAlign: TextAlign.center),
            if (price != null) ...[
              const SizedBox(height: AppTheme.spacingXs),
              Text(price!, style: text.headlineMedium?.copyWith(color: colors.primary), textAlign: TextAlign.center),
            ],
            const SizedBox(height: AppTheme.spacingMd),
            if (!isStoreSupported)
              Text(
                'Prices and purchases are available in the Android and iOS app.',
                style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                textAlign: TextAlign.center,
              )
            else if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (productError != null) ...[
              StatusMessage(message: productError!, isError: true),
              const SizedBox(height: AppTheme.spacingSm),
              OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
            ],
            if (isPending) ...[
              const SizedBox(height: AppTheme.spacingSm),
              const StatusMessage(message: 'Waiting for payment approval. Access unlocks as soon as it completes.'),
            ],
            if (errorMessage != null) ...[
              const SizedBox(height: AppTheme.spacingSm),
              StatusMessage(message: errorMessage!, isError: true),
            ],
            if (noticeMessage != null) ...[
              const SizedBox(height: AppTheme.spacingSm),
              StatusMessage(message: noticeMessage!),
            ],
            const SizedBox(height: AppTheme.spacingMd),
            FilledButton(
              onPressed: canBuy ? onBuy : null,
              child: isBusy
                  ? SizedBox(
                      width: AppTheme.progressSize,
                      height: AppTheme.progressSize,
                      child: CircularProgressIndicator(strokeWidth: AppTheme.progressStroke, color: colors.onPrimary),
                    )
                  : const Text('Unlock unlimited access'),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            TextButton(
              onPressed: isStoreSupported && !isBusy ? onRestore : null,
              child: const Text('Restore purchases'),
            ),
          ],
        ],
      ),
    );
  }
}
