import '../models/purchase_models.dart';
import '../repositories/purchases_repository.dart';

class PurchaseService {
  PurchaseService({required PurchasesRepository repository}) : _repository = repository;

  final PurchasesRepository _repository;

  bool get isStoreSupported => _repository.isStoreSupported;
  bool get isPremium => _repository.isPremium;
  Stream<PurchaseEvent> get events => _repository.events;

  Future<void> init() => _repository.init();
  Future<StoreProduct> loadProduct() => _repository.loadProduct();
  Future<void> buy() => _repository.buy();
  Future<void> restore() => _repository.restore();
  Future<void> refresh() => _repository.refresh();
}
