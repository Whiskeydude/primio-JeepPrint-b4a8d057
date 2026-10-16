/// The single one-time (non-consumable) product sold in the app.
/// The price is set in Google Play Console and App Store Connect, never here.
class PremiumCatalog {
  PremiumCatalog._();

  static const String productId = 'premium_unlimited';

  static const List<String> benefits = [
    'Every owner comment for every problem part',
    'Print-ready STL downloads for every part',
    'All Jeep models and years in the catalog',
    'One payment, no subscription',
  ];
}
