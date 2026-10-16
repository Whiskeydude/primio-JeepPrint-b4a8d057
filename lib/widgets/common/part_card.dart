import 'package:flutter/material.dart';

import '../../models/jeep_part.dart';
import '../../theme/theme.dart';
import 'severity_badge.dart';

class PartCard extends StatelessWidget {
  final JeepPart part;
  final int rank;
  final VoidCallback onTap;

  const PartCard({super.key, required this.part, required this.rank, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMd - AppTheme.spacingXs),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    child: Image.asset(
                      part.imageAsset,
                      width: AppTheme.thumbnailSize,
                      height: AppTheme.thumbnailSize,
                      fit: BoxFit.cover,
                      cacheWidth: AppTheme.imageCacheSize ~/ 2,
                      semanticLabel: part.name,
                    ),
                  ),
                  Positioned(
                    top: AppTheme.spacingXs,
                    left: AppTheme.spacingXs,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSm - 2, vertical: 2),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                      ),
                      child: Text('#$rank', style: text.labelSmall?.copyWith(color: colors.onPrimary)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(part.category.toUpperCase(), style: text.labelSmall?.copyWith(color: colors.secondary)),
                    const SizedBox(height: 2),
                    Text(part.name, style: text.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: AppTheme.spacingXs),
                    Text(
                      '${part.reportCount} owner reports',
                      style: text.bodySmall?.copyWith(color: appColors.subtleText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Wrap(
                      spacing: AppTheme.spacingSm,
                      runSpacing: AppTheme.spacingXs,
                      children: [
                        SeverityBadge(severity: part.severity),
                        Text(
                          'Save ${part.savingsPercent}%',
                          style: text.labelMedium?.copyWith(color: appColors.success, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
