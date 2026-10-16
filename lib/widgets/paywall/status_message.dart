import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StatusMessage extends StatelessWidget {
  final String message;
  final bool isError;

  const StatusMessage({super.key, required this.message, this.isError = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final color = isError ? appColors.danger : appColors.success;
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingSm + 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      ),
      child: Row(
        children: [
          Icon(isError ? Icons.error_outline_rounded : Icons.info_outline_rounded, color: color),
          const SizedBox(width: AppTheme.spacingSm),
          Expanded(child: Text(message, style: theme.textTheme.bodySmall?.copyWith(color: color))),
        ],
      ),
    );
  }
}
