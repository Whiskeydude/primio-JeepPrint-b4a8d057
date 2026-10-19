import 'package:go_router/go_router.dart';
import '../screens/coming_soon_screen.dart';
import '../screens/garage_screen.dart';
import '../screens/part_detail_screen.dart';
import '../screens/paywall_screen.dart';
import '../screens/privacy_policy_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const GarageScreen()),
      GoRoute(
        path: '/part/:id',
        builder: (context, state) => PartDetailScreen(partId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/premium', builder: (context, state) => const PaywallScreen()),
      GoRoute(path: '/privacy', builder: (context, state) => const PrivacyPolicyScreen()),
      GoRoute(
        path: '/soon',
        builder: (context, state) => ComingSoonScreen(
          title: state.uri.queryParameters['title'] ?? 'Coming soon',
          description: state.uri.queryParameters['desc'] ?? '',
        ),
      ),
    ],
  );
}
