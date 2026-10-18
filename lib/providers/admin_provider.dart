import 'package:flutter/foundation.dart';

import '../services/admin_service.dart';

class AdminProvider extends ChangeNotifier {
  final AdminService _service;

  AdminProvider({required AdminService service}) : _service = service;

  bool isLoading = true;
  bool isBusy = false;
  String? signedInEmail;
  String? errorMessage;

  bool get isSignedIn => signedInEmail != null;

  Future<void> load() async {
    try {
      signedInEmail = _service.restoredAdminEmail();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> submit(String email, String password) async {
    isBusy = true;
    errorMessage = null;
    notifyListeners();
    try {
      signedInEmail = await _service.signIn(email, password);
    } catch (e) {
      errorMessage = e.toString();
    }
    isBusy = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    isBusy = true;
    errorMessage = null;
    notifyListeners();
    try {
      await _service.signOut();
      signedInEmail = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    isBusy = false;
    notifyListeners();
  }
}
