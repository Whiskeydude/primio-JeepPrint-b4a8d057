class StoreProduct {
  final String id;
  final String title;
  final String price;

  const StoreProduct({required this.id, required this.title, required this.price});
}

enum PurchaseEventStatus { pending, purchased, restored, canceled, nothingToRestore, error }

class PurchaseEvent {
  final PurchaseEventStatus status;
  final String? message;

  const PurchaseEvent(this.status, [this.message]);
}

class PurchaseException implements Exception {
  final String message;

  const PurchaseException(this.message);

  @override
  String toString() => message;
}
