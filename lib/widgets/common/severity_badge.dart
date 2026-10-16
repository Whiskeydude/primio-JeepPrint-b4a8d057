import 'package:flutter/material.dart';

import '../../models/jeep_part.dart';
import '../../theme/theme.dart';

class SeverityBadge extends StatelessWidget {
  final Severity severity;

  const SeverityBadge({super.key, required this.severity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final (label, color) = switch (severity) {
      Severity.high => ('Fails often', appColors.danger),
      Severity.moderate => ('Common', appColors.warning),
      Severity.low => ('Occasional', appColors.success),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSm, vertical: AppTheme.spacingXs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: AppTheme.opacitySoft),
        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
      ),
      child: Text(label, style: theme.textTheme.labelSmall?.copyWith(color: color)),
    );
  }
}
