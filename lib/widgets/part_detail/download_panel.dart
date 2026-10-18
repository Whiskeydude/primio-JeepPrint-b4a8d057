import 'package:flutter/material.dart';

import '../../models/export_result.dart';
import '../../theme/theme.dart';

class DownloadPanel extends StatelessWidget {
  final String material;
  final String printNotes;
  final String dimensions;
  final PrintFormat? downloadingFormat;
  final String? errorMessage;
  final VoidCallback onDownloadStl;
  final VoidCallback onDownload3mf;

  const DownloadPanel({
    super.key,
    required this.material,
    required this.printNotes,
    required this.dimensions,
    required this.downloadingFormat,
    required this.errorMessage,
    required this.onDownloadStl,
    required this.onDownload3mf,
  });

  bool get busy => downloadingFormat != null;

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
            onPressed: busy ? null : onDownloadStl,
            icon: downloadingFormat == PrintFormat.stl
                ? SizedBox(
                    width: AppTheme.progressSize,
                    height: AppTheme.progressSize,
                    child: CircularProgressIndicator(strokeWidth: AppTheme.progressStroke, color: colors.onPrimary),
                  )
                : const Icon(Icons.download_rounded),
            label: Text(downloadingFormat == PrintFormat.stl ? 'Preparing STL…' : 'Download STL'),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          OutlinedButton.icon(
            onPressed: busy ? null : onDownload3mf,
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.onPrimaryContainer,
              side: BorderSide(color: colors.onPrimaryContainer.withValues(alpha: AppTheme.opacityHint)),
            ),
            icon: downloadingFormat == PrintFormat.threeMf
                ? SizedBox(
                    width: AppTheme.progressSize,
                    height: AppTheme.progressSize,
                    child: CircularProgressIndicator(strokeWidth: AppTheme.progressStroke, color: colors.onPrimaryContainer),
                  )
                : const Icon(Icons.view_in_ar_rounded),
            label: Text(downloadingFormat == PrintFormat.threeMf ? 'Preparing 3MF…' : 'Download 3MF'),
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
