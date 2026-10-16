import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/premium_catalog.dart';
import '../models/purchase_models.dart';

class PurchasesRepository {
  static const _premiumKey = 'premium_unlocked';
  static const _grantKey = 'premium_grant_id';

  final StreamController<PurchaseEvent> _events = StreamController<PurchaseEvent>.broadcast();
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  SharedPreferences? _prefs;
  ProductDetails? _product;
  bool _restoring = false;

  bool get isStoreSupported =>
      !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
  bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;
  Stream<PurchaseEvent> get events => _events.stream;
  bool get isPremium => _prefs?.getBool(_premiumKey) ?? false;

  /// Opens local storage and starts listening to the store before anything else runs.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    if (!isStoreSupported) return;
    _subscription = InAppPurchase.instance.purchaseStream.listen(
      _onPurchases,
      onError: (Object e) => _events.add(PurchaseEvent(PurchaseEventStatus.error, e.toString())),
    );
  }

  Future<StoreProduct> loadProduct() async {
    final iap = InAppPurchase.instance;
    if (!await iap.isAvailable()) {
      throw const PurchaseException(
        'The store is not available right now. Check your connection and your Google Play or App Store account.',
      );
    }
    final response = await iap.queryProductDetails({PremiumCatalog.productId});
    if (response.error != null) throw PurchaseException(response.error!.message);
    if (response.productDetails.isEmpty) {
      throw const PurchaseException(
        'The product "${PremiumCatalog.productId}" is not set up in the store yet.',
      );
    }
    final product = response.productDetails.first;
    _product = product;
    return StoreProduct(id: product.id, title: product.title, price: product.price);
  }

  Future<void> buy() async {
    final product = _product;
    if (product == null) throw const PurchaseException('The product has not loaded yet.');
    final started = await InAppPurchase.instance.buyNonConsumable(
      purchaseParam: PurchaseParam(productDetails: product),
    );
    if (!started) throw const PurchaseException('The store could not start the purchase.');
  }

  /// Re-checks what the store account owns. Returns whether the product was found
  /// (iOS results arrive on the purchase stream instead).
  Future<bool> refresh() async {
    if (!isStoreSupported) return false;
    final iap = InAppPurchase.instance;
    if (_isAndroid) {
      final addition = iap.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final response = await addition.queryPastPurchases();
      if (response.error != null) throw PurchaseException(response.error!.message);
      final owned = response.pastPurchases.where((p) => p.productID == PremiumCatalog.productId).toList();
      if (owned.isEmpty) {
        await _setPremium(false, '');
        return false;
      }
      await _onPurchases(owned);
      return true;
    }
    await iap.restorePurchases();
    return true;
  }

  Future<void> restore() async {
    if (_isAndroid) {
      final found = await refresh();
      if (!found) _events.add(const PurchaseEvent(PurchaseEventStatus.nothingToRestore));
      return;
    }
    _restoring = true;
    try {
      await InAppPurchase.instance.restorePurchases();
    } catch (_) {
      _restoring = false;
      rethrow;
    }
  }

  Future<void> _onPurchases(List<PurchaseDetails> purchases) async {
    final premium = purchases.where((p) => p.productID == PremiumCatalog.productId).toList();
    if (_restoring) {
      if (premium.isEmpty && purchases.every((p) => p.status == PurchaseStatus.restored)) {
        _restoring = false;
        _events.add(const PurchaseEvent(PurchaseEventStatus.nothingToRestore));
      } else if (premium.isNotEmpty) {
        _restoring = false;
      }
    }
    for (final details in purchases) {
      if (details.productID != PremiumCatalog.productId) {
        await _finish(details);
        continue;
      }
      switch (details.status) {
        case PurchaseStatus.pending:
          _events.add(const PurchaseEvent(PurchaseEventStatus.pending));
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if (_isAndroidPending(details)) {
            _events.add(const PurchaseEvent(PurchaseEventStatus.pending));
            continue;
          }
          await _setPremium(true, _grantId(details));
          await _finish(details);
          _events.add(PurchaseEvent(
            details.status == PurchaseStatus.restored
                ? PurchaseEventStatus.restored
                : PurchaseEventStatus.purchased,
          ));
        case PurchaseStatus.error:
          await _finish(details);
          _events.add(PurchaseEvent(PurchaseEventStatus.error, details.error?.message ?? 'The purchase failed.'));
        case PurchaseStatus.canceled:
          await _finish(details);
          _events.add(const PurchaseEvent(PurchaseEventStatus.canceled));
      }
    }
  }

  bool _isAndroidPending(PurchaseDetails details) =>
      details is GooglePlayPurchaseDetails &&
      details.billingClientPurchase.purchaseState != PurchaseStateWrapper.purchased;

  String _grantId(PurchaseDetails details) =>
      _isAndroid ? details.verificationData.serverVerificationData : (details.purchaseID ?? '');

  Future<void> _setPremium(bool value, String grantId) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setBool(_premiumKey, value);
    await prefs.setString(_grantKey, grantId);
  }

  Future<void> _finish(PurchaseDetails details) async {
    if (!details.pendingCompletePurchase) return;
    try {
      await InAppPurchase.instance.completePurchase(details);
    } catch (_) {
      // The unlock is already saved. The store returns unfinished purchases on the
      // next refresh, which retries finishing them.
    }
  }

  void dispose() {
    _subscription?.cancel();
    _events.close();
  }
}
