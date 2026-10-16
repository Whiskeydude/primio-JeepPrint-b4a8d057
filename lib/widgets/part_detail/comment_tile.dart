import 'package:flutter/material.dart';

import '../../models/jeep_part.dart';
import '../../theme/theme.dart';

class CommentTile extends StatelessWidget {
  final OwnerComment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm + 2),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border(left: BorderSide(color: colors.primary, width: AppTheme.borderThick * 1.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: AppTheme.iconSm,
                backgroundColor: colors.secondaryContainer,
                child: Text(
                  comment.author.substring(0, 1).toUpperCase(),
                  style: text.labelLarge?.copyWith(color: colors.onSecondaryContainer),
                ),
              ),
              const SizedBox(width: AppTheme.spacingSm + 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.author, style: text.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(comment.vehicle,
                        style: text.bodySmall?.copyWith(color: appColors.subtleText),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSm + 2),
          Text('“${comment.text}”', style: text.bodyMedium),
          const SizedBox(height: AppTheme.spacingSm),
          Row(
            children: [
              Icon(Icons.thumb_up_alt_rounded, size: AppTheme.iconSm, color: appColors.subtleText),
              const SizedBox(width: AppTheme.spacingXs),
              Text('${comment.helpful} found this helpful',
                  style: text.bodySmall?.copyWith(color: appColors.subtleText)),
            ],
          ),
        ],
      ),
    );
  }
}
