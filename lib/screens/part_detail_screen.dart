import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/export_result.dart';
import '../models/jeep_part.dart';
import '../providers/app/garage_provider.dart';
import '../providers/app/premium_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';
import '../widgets/common/section_header.dart';
import '../widgets/common/severity_badge.dart';
import '../widgets/part_detail/comment_tile.dart';
import '../widgets/part_detail/download_panel.dart';
import '../widgets/part_detail/locked_section.dart';
import '../widgets/part_detail/price_compare_card.dart';

class PartDetailScreen extends StatelessWidget {
  final String partId;

  const PartDetailScreen({super.key, required this.partId});

  Future<void> _download(BuildContext context, JeepPart part, PrintFormat format) async {
    final garage = context.read<GarageProvider>();
    await garage.download(part, format);
    if (!context.mounted || garage.exportMessage == null || garage.exportFailed) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(garage.exportMessage!)));
  }

  @override
  Widget build(BuildContext context) {
    final garage = context.watch<GarageProvider>();
    final premium = context.watch<PremiumProvider>();
    final part = garage.partById(partId);
    final theme = Theme.of(context);
    final text = theme.textTheme;

    if (part == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const SafeArea(child: Center(child: Text('This part could not be found.'))),
      );
    }

    final gap = ResponsiveLayout.getSpacing(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: AppTheme.detailHeroHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: part.id,
                child: Image.asset(part.imageAsset, fit: BoxFit.cover, cacheWidth: AppTheme.imageCacheSize * 2),
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: ResponsiveLayout.getPadding(context),
              sliver: SliverToBoxAdapter(
                child: ResponsiveLayout.constrain(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SeverityBadge(severity: part.severity),
                          const SizedBox(width: AppTheme.spacingSm),
                          Flexible(
                            child: Text('${part.reportCount} owner reports • ${part.category}',
                                style: text.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingSm),
                      Text(part.name, style: text.headlineLarge),
                      const SizedBox(height: AppTheme.spacingXs),
                      Text(part.summary, style: text.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                      SizedBox(height: gap * 1.5),
                      PriceCompareCard(
                        dealerPrice: part.dealerPrice,
                        printPrice: part.printPrice,
                        savingsPercent: part.savingsPercent,
                      ),
                      SizedBox(height: gap * 1.5),
                      const SectionHeader(title: 'Why it breaks'),
                      Text(part.failureReason, style: text.bodyMedium),
                      SizedBox(height: gap * 1.5),
                      SectionHeader(
                        title: 'What owners say',
                        subtitle: premium.isPremium ? '${part.comments.length} top comments' : 'Free preview',
                      ),
                      for (final c in premium.isPremium ? part.comments : part.comments.take(1))
                        CommentTile(comment: c),
                      SizedBox(height: gap),
                      if (premium.isPremium)
                        DownloadPanel(
                          material: part.material,
                          printNotes: part.printNotes,
                          dimensions: '${part.widthMm.round()}×${part.depthMm.round()}×${part.heightMm.round()} mm',
                          downloadingFormat: garage.downloadingId == part.id ? garage.downloadingFormat : null,
                          errorMessage: garage.exportFailed ? garage.exportMessage : null,
                          onDownloadStl: () => _download(context, part, PrintFormat.stl),
                          onDownload3mf: () => _download(context, part, PrintFormat.threeMf),
                        )
                      else
                        LockedSection(
                          hiddenComments: part.comments.isEmpty ? 0 : part.comments.length - 1,
                          onUnlock: () => context.push('/premium'),
                        ),
                      SizedBox(height: gap * 1.5),
                      const SectionHeader(title: 'Fits'),
                      Wrap(
                        spacing: AppTheme.spacingSm,
                        runSpacing: AppTheme.spacingSm,
                        children: [for (final f in part.fitments) Chip(label: Text(f.label))],
                      ),
                      const SizedBox(height: AppTheme.spacingXl),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
