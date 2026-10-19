import '../models/admin_exception.dart';
import '../repositories/admin_repository.dart';

class AdminService {
  static const adminEmail = 'ecwfire@gmail.com';
  static const secondAdminEmail = 'edwincwright@yahoo.com';

  final AdminRepository _repository;

  AdminService({required AdminRepository repository}) : _repository = repository;

  bool _isAdmin(String? email) {
    if (email == null) return false;
    final normalized = email.trim().toLowerCase();
    return normalized == adminEmail || normalized == secondAdminEmail;
  }

  /// Email of the restored session when it belongs to the admin, otherwise null.
  String? restoredAdminEmail() {
    final email = _repository.currentEmail();
    return _isAdmin(email) ? email : null;
  }

  Future<String> signIn(String email, String password) async {
    if (!_isAdmin(email)) {
      throw const AdminException('This account does not have admin access.');
    }
    final signedInEmail = await _repository.signIn(email.trim(), password);
    if (!_isAdmin(signedInEmail)) {
      await _repository.signOut();
      throw const AdminException('This account does not have admin access.');
    }
    return signedInEmail!;
  }

  Future<void> signOut() => _repository.signOut();
}
