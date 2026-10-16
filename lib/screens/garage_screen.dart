import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/app/garage_provider.dart';
import '../providers/app/premium_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';
import '../widgets/common/part_card.dart';
import '../widgets/common/section_header.dart';
import '../widgets/garage/garage_hero.dart';
import '../widgets/garage/premium_banner.dart';
import '../widgets/garage/tools_grid.dart';
import '../widgets/garage/vehicle_selector.dart';

class GarageScreen extends StatelessWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final garage = context.watch<GarageProvider>();
    final isPremium = context.watch<PremiumProvider>().isPremium;
    final theme = Theme.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final padding = ResponsiveLayout.getPadding(context);
    final results = garage.results;

    Widget section(Widget child) => SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding.left),
            child: ResponsiveLayout.constrain(child),
          ),
        );

    return AnnotatedRegion(
      value: theme.appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: GarageHero(totalReports: garage.totalReports)),
              section(VehicleSelector(
                models: garage.models,
                selectedModel: garage.model,
                selectedYear: garage.year,
                onModelChanged: garage.selectModel,
                onYearChanged: garage.selectYear,
              )),
              if (!isPremium) ...[
                const SliverToBoxAdapter(child: SizedBox(height: AppTheme.spacingMd)),
                section(PremiumBanner(onTap: () => context.push('/premium'))),
              ],
              const SliverToBoxAdapter(child: SizedBox(height: AppTheme.spacingLg)),
              section(SectionHeader(
                title: 'What breaks on the ${garage.year} ${garage.model.name}',
                subtitle: results.isEmpty
                    ? 'No owner reports for this year yet.'
                    : '${results.length} parts ranked by owner reports',
              )),
              SliverList.builder(
                itemCount: results.length,
                itemBuilder: (context, i) {
                  final part = results[i];
                  Widget card = Padding(
                    padding: EdgeInsets.fromLTRB(padding.left, 0, padding.right, AppTheme.spacingSm + 2),
                    child: ResponsiveLayout.constrain(PartCard(
                      part: part,
                      rank: i + 1,
                      onTap: () => context.push('/part/${part.id}'),
                    )),
                  );
                  if (!reduceMotion) {
                    card = card
                        .animate(key: ValueKey('${garage.model.code}${garage.year}${part.id}'), delay: 70.ms * i)
                        .fadeIn(duration: 380.ms)
                        .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic);
                  }
                  return card;
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppTheme.spacingLg)),
              section(const SectionHeader(title: 'More tools', subtitle: 'In the workshop now')),
              section(ToolsGrid(
                onOpen: (title, desc) => context.push(
                  Uri(path: '/soon', queryParameters: {'title': title, 'desc': desc}).toString(),
                ),
              )),
              const SliverToBoxAdapter(child: SizedBox(height: AppTheme.spacingXl)),
            ],
          ),
        ),
      ),
    );
  }
}
