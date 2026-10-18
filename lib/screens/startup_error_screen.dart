import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../widgets/paywall/status_message.dart';

class StartupErrorScreen extends StatelessWidget {
  final String message;

  const StartupErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('JeepPrint could not start', style: text.headlineMedium),
                const SizedBox(height: AppTheme.spacingMd),
                StatusMessage(message: message, isError: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
