import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/admin_exception.dart';

class AdminRepository {
  GoTrueClient get _auth => Supabase.instance.client.auth;

  String? currentEmail() => _auth.currentUser?.email;

  Future<String?> signIn(String email, String password) async {
    try {
      final response = await _auth.signInWithPassword(email: email, password: password);
      return response.user?.email;
    } on AuthException catch (e) {
      throw AdminException(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on AuthException catch (e) {
      throw AdminException(e.message);
    }
  }
}
