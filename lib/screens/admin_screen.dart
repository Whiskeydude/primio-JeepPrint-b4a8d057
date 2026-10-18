import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/admin_provider.dart';
import '../theme/responsive_layout.dart';
import '../widgets/admin/admin_login_form.dart';
import '../widgets/admin/admin_panel.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AdminProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Admin')),
      body: SafeArea(
        child: admin.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: ResponsiveLayout.getPadding(context),
                child: ResponsiveLayout.constrain(
                  admin.isSignedIn
                      ? AdminPanel(email: admin.signedInEmail!, isBusy: admin.isBusy, onSignOut: admin.signOut)
                      : AdminLoginForm(
                          isBusy: admin.isBusy,
                          errorMessage: admin.errorMessage,
                          onSubmit: admin.submit,
                        ),
                ),
              ),
      ),
    );
  }
}
