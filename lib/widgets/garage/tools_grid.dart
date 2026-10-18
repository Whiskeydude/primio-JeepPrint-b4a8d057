import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class _Tool {
  final IconData icon;
  final String title;
  final String description;
  const _Tool(this.icon, this.title, this.description);
}

const _tools = [
  _Tool(Icons.storefront_rounded, 'Print Shop Finder', 'Find nearby 3D print shops and compare quotes.'),
  _Tool(Icons.forum_rounded, 'Share a Failure', 'Post your own broken-part report and photos.'),
  _Tool(Icons.garage_rounded, 'My Garage', 'Save several Jeeps and get alerts for new parts.'),
];

class ToolsGrid extends StatelessWidget {
  final void Function(String title, String description) onOpen;

  const ToolsGrid({super.key, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 600 ? 4 : 2;
        final itemWidth = ((constraints.maxWidth - AppTheme.spacingSm * (columns - 1)) / columns).clamp(0.0, double.infinity);
        return Wrap(
          spacing: AppTheme.spacingSm,
          runSpacing: AppTheme.spacingSm,
          children: [
            for (final t in _tools)
              SizedBox(
                width: itemWidth,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => onOpen(t.title, t.description),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(t.icon, color: colors.secondary, size: AppTheme.iconLg),
                              const Spacer(),
                              Text('SOON', style: theme.textTheme.labelSmall?.copyWith(color: colors.primary)),
                            ],
                          ),
                          const SizedBox(height: AppTheme.spacingSm),
                          Text(t.title, style: theme.textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: AppTheme.spacingXs),
                          Text(
                            t.description,
                            style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
