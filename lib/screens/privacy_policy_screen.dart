import 'package:flutter/material.dart';

import '../theme/responsive_layout.dart';
import '../theme/theme.dart';
import '../widgets/common/section_header.dart';
import '../widgets/privacy/privacy_section.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SectionHeader(
                  title: 'JeepPrint privacy policy',
                  subtitle: 'Last updated October 17, 2026',
                ),
                SizedBox(height: AppTheme.spacingSm),
                PrivacySection(
                  title: 'What JeepPrint is',
                  body: 'JeepPrint helps Jeep owners find parts that often break on their model and year, '
                      'and download 3D-printable replacement files (STL and 3MF).',
                ),
                PrivacySection(
                  title: 'Information stored on your device',
                  body: 'The app keeps your selected model and year, and whether unlimited access has been '
                      'unlocked, so the app opens the way you left it. This information stays on your device '
                      'and is not sent to us.',
                ),
                PrivacySection(
                  title: 'Purchases',
                  body: 'Unlimited access is sold through Google Play on Android and the App Store on iPhone. '
                      'Payment details are handled only by the store. JeepPrint receives confirmation that a '
                      'purchase was made and never sees your payment information.',
                ),
                PrivacySection(
                  title: 'Downloaded print files',
                  body: 'STL and 3MF files are created on your device. Sharing or saving a file goes through '
                      'your device\'s own share menu or your browser, and is under your control.',
                ),
                PrivacySection(
                  title: 'Analytics, ads and tracking',
                  body: 'JeepPrint does not include advertising, analytics or tracking tools, and does not '
                      'collect your location or contacts.',
                ),
                PrivacySection(
                  title: 'Parts information and owner comments',
                  body: 'The parts list and owner comments are part of the app content. They are not linked '
                      'to any individual user.',
                ),
                PrivacySection(
                  title: 'Children',
                  body: 'JeepPrint is not directed at children under 13 and does not knowingly collect '
                      'information from them.',
                ),
                PrivacySection(
                  title: 'Changes to this policy',
                  body: 'If this policy changes, the updated version will appear on this screen with a new '
                      'date at the top.',
                ),
                SizedBox(height: AppTheme.spacingXl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
