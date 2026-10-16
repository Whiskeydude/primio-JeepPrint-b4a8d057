import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class GarageHero extends StatelessWidget {
  final int totalReports;

  const GarageHero({super.key, required this.totalReports});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    final scrim = theme.extension<AppColorsExtension>()!.heroScrim;
    final topInset = MediaQuery.paddingOf(context).top;
    return SizedBox(
      height: AppTheme.heroHeight + topInset,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/jeep_hero.jpg', fit: BoxFit.cover, cacheWidth: AppTheme.imageCacheSize * 2),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  scrim.withValues(alpha: AppTheme.opacityScrimTop),
                  scrim.withValues(alpha: AppTheme.opacityScrimMid),
                  scrim,
                ],
                stops: const [0, 0.55, 1],
              ),
            ),
          ),
          Positioned(
            left: AppTheme.spacingMd,
            right: AppTheme.spacingMd,
            bottom: AppTheme.spacingMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSm + 2, vertical: AppTheme.spacingXs),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                  ),
                  child: Text('$totalReports OWNER REPORTS', style: text.labelSmall?.copyWith(color: colors.onPrimary)),
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Text('JeepPrint', style: text.displaySmall),
                Text(
                  'Find what breaks on your Jeep. Print it stronger, for less.',
                  style: text.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
