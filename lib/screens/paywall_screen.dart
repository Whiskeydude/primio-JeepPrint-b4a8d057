import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/premium_catalog.dart';
import '../providers/app/premium_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';
import '../widgets/paywall/paywall_benefits.dart';
import '../widgets/paywall/paywall_header.dart';
import '../widgets/paywall/paywall_purchase_card.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final premium = context.watch<PremiumProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Go unlimited')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              children: [
                const PaywallHeader(),
                const SizedBox(height: AppTheme.spacingLg),
                const PaywallBenefits(benefits: PremiumCatalog.benefits),
                const SizedBox(height: AppTheme.spacingLg),
                PaywallPurchaseCard(
                  isPremium: premium.isPremium,
                  isStoreSupported: premium.isStoreSupported,
                  isLoading: premium.isLoadingProduct,
                  isBusy: premium.isBusy,
                  isPending: premium.isPending,
                  price: premium.product?.price,
                  productError: premium.productError,
                  errorMessage: premium.errorMessage,
                  noticeMessage: premium.noticeMessage,
                  onBuy: premium.buy,
                  onRestore: premium.restore,
                  onRetry: premium.loadProduct,
                  onDone: () => context.pop(),
                ),
                const SizedBox(height: AppTheme.spacingXl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
