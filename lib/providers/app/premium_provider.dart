import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../models/purchase_models.dart';
import '../../services/purchase_service.dart';

class PremiumProvider extends ChangeNotifier {
  PremiumProvider({required PurchaseService service}) : _service = service;

  final PurchaseService _service;
  StreamSubscription<PurchaseEvent>? _subscription;
  bool _isPremium = false;
  StoreProduct? _product;
  bool _isLoadingProduct = false;
  String? _productError;
  bool _isBusy = false;
  bool _isPending = false;
  String? _errorMessage;
  String? _noticeMessage;

  bool get isPremium => _isPremium;
  bool get isStoreSupported => _service.isStoreSupported;
  StoreProduct? get product => _product;
  bool get isLoadingProduct => _isLoadingProduct;
  String? get productError => _productError;
  bool get isBusy => _isBusy;
  bool get isPending => _isPending;
  String? get errorMessage => _errorMessage;
  String? get noticeMessage => _noticeMessage;

  Future<void> init() async {
    try {
      await _service.init();
    } catch (e) {
      _productError = 'Could not start purchases: $e';
      notifyListeners();
      return;
    }
    _isPremium = _service.isPremium;
    _subscription = _service.events.listen(_onEvent);
    notifyListeners();
    if (!isStoreSupported) return;
    await Future.wait([loadProduct(), _refreshEntitlement()]);
  }

  Future<void> loadProduct() async {
    _isLoadingProduct = true;
    _productError = null;
    notifyListeners();
    try {
      _product = await _service.loadProduct();
    } catch (e) {
      _productError = e.toString();
    } finally {
      _isLoadingProduct = false;
      notifyListeners();
    }
  }

  Future<void> buy() async {
    _isBusy = true;
    _errorMessage = null;
    _noticeMessage = null;
    notifyListeners();
    try {
      await _service.buy();
    } catch (e) {
      _isBusy = false;
      _errorMessage = 'Could not start the purchase: $e';
      notifyListeners();
    }
  }

  Future<void> restore() async {
    _isBusy = true;
    _errorMessage = null;
    _noticeMessage = null;
    notifyListeners();
    try {
      await _service.restore();
    } catch (e) {
      _isBusy = false;
      _errorMessage = 'Could not restore purchases: $e';
      notifyListeners();
    }
  }

  Future<void> _refreshEntitlement() async {
    try {
      await _service.refresh();
      _isPremium = _service.isPremium;
      notifyListeners();
    } catch (_) {
      // Offline or store hiccup: keep the saved unlock until a refresh succeeds.
    }
  }

  void _onEvent(PurchaseEvent event) {
    switch (event.status) {
      case PurchaseEventStatus.pending:
        _isPending = true;
        _isBusy = false;
      case PurchaseEventStatus.purchased:
      case PurchaseEventStatus.restored:
        _isPremium = _service.isPremium;
        _isBusy = false;
        _isPending = false;
        _errorMessage = null;
        _noticeMessage = event.status == PurchaseEventStatus.restored
            ? 'Your purchase was restored.'
            : 'Unlimited access unlocked.';
      case PurchaseEventStatus.canceled:
        _isBusy = false;
        _isPending = false;
      case PurchaseEventStatus.nothingToRestore:
        _isBusy = false;
        _noticeMessage = 'No previous purchases found.';
      case PurchaseEventStatus.error:
        _isBusy = false;
        _isPending = false;
        _errorMessage = event.message ?? 'The purchase failed.';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
