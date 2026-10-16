import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class DownloadPanel extends StatelessWidget {
  final String material;
  final String printNotes;
  final String dimensions;
  final bool isDownloading;
  final String? errorMessage;
  final VoidCallback onDownloadStl;
  final VoidCallback onOpen3mf;

  const DownloadPanel({
    super.key,
    required this.material,
    required this.printNotes,
    required this.dimensions,
    required this.isDownloading,
    required this.errorMessage,
    required this.onDownloadStl,
    required this.onOpen3mf,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Print-ready file', style: text.titleLarge?.copyWith(color: colors.onPrimaryContainer)),
          const SizedBox(height: AppTheme.spacingSm),
          Text('Material: $material  •  $dimensions',
              style: text.labelLarge?.copyWith(color: colors.onPrimaryContainer)),
          const SizedBox(height: AppTheme.spacingXs),
          Text(printNotes, style: text.bodyMedium?.copyWith(color: colors.onPrimaryContainer)),
          const SizedBox(height: AppTheme.spacingMd),
          FilledButton.icon(
            onPressed: isDownloading ? null : onDownloadStl,
            icon: isDownloading
                ? SizedBox(
                    width: AppTheme.progressSize,
                    height: AppTheme.progressSize,
                    child: CircularProgressIndicator(strokeWidth: AppTheme.progressStroke, color: colors.onPrimary),
                  )
                : const Icon(Icons.download_rounded),
            label: Text(isDownloading ? 'Preparing STL…' : 'Download STL'),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          OutlinedButton.icon(
            onPressed: onOpen3mf,
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.onPrimaryContainer,
              side: BorderSide(color: colors.onPrimaryContainer.withValues(alpha: AppTheme.opacityHint)),
            ),
            icon: const Icon(Icons.view_in_ar_rounded),
            label: const Text('3MF – coming soon'),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: AppTheme.spacingSm),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSm + 2),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline_rounded, color: appColors.danger),
                  const SizedBox(width: AppTheme.spacingSm),
                  Expanded(
                    child: Text(errorMessage!, style: text.bodySmall?.copyWith(color: appColors.danger)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
