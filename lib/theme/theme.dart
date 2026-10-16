import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color success;
  final Color warning;
  final Color danger;
  final Color subtleText;
  final Color heroScrim;

  const AppColorsExtension({
    required this.success,
    required this.warning,
    required this.danger,
    required this.subtleText,
    required this.heroScrim,
  });

  @override
  AppColorsExtension copyWith({
    Color? success,
    Color? warning,
    Color? danger,
    Color? subtleText,
    Color? heroScrim,
  }) {
    return AppColorsExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      subtleText: subtleText ?? this.subtleText,
      heroScrim: heroScrim ?? this.heroScrim,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      subtleText: Color.lerp(subtleText, other.subtleText, t)!,
      heroScrim: Color.lerp(heroScrim, other.heroScrim, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 14.0;
  static const double radiusLarge = 20.0;
  static const double radiusPill = 100.0;

  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 56.0;

  static const double buttonHeight = 52.0;
  static const double thumbnailSize = 88.0;
  static const double heroHeight = 300.0;
  static const double detailHeroHeight = 320.0;
  static const double progressSize = 18.0;
  static const double progressStroke = 2.4;
  static const int imageCacheSize = 600;

  static const double opacityDisabled = 0.38;
  static const double opacityHint = 0.6;
  static const double opacitySoft = 0.14;
  static const double opacityScrimTop = 0.15;
  static const double opacityScrimMid = 0.6;

  static const double borderDefault = 1.0;
  static const double borderThick = 2.0;

  static final ThemeData theme = _buildTheme(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF2A33A),
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFFF2A33A),
      onPrimary: const Color(0xFF1E1404),
      primaryContainer: const Color(0xFF4A3410),
      onPrimaryContainer: const Color(0xFFFFDDB0),
      secondary: const Color(0xFF9DAF6A),
      onSecondary: const Color(0xFF151A0A),
      secondaryContainer: const Color(0xFF2F3A1C),
      onSecondaryContainer: const Color(0xFFDCEBB0),
      surface: const Color(0xFF121410),
      onSurface: const Color(0xFFECE7DC),
      onSurfaceVariant: const Color(0xFFB9B4A6),
      surfaceContainerLow: const Color(0xFF1A1D17),
      surfaceContainer: const Color(0xFF20241C),
      surfaceContainerHigh: const Color(0xFF282C23),
      surfaceContainerHighest: const Color(0xFF31362B),
      outline: const Color(0xFF4A5040),
      outlineVariant: const Color(0xFF353A2E),
    ),
    appColors: const AppColorsExtension(
      success: Color(0xFF8FD18B),
      warning: Color(0xFFF5C451),
      danger: Color(0xFFFF8A7A),
      subtleText: Color(0xFFA19C8F),
      heroScrim: Color(0xFF121410),
    ),
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required AppColorsExtension appColors,
  }) {
    final textTheme = _buildTextTheme(colorScheme);
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium));
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarThemeData(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, buttonHeight),
          shape: shape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, buttonHeight),
          shape: shape,
          side: BorderSide(color: colorScheme.outline),
          textStyle: textTheme.labelLarge,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedColor: colorScheme.primary,
        labelStyle: textTheme.labelLarge,
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
        checkmarkColor: colorScheme.onPrimary,
        side: BorderSide(color: colorScheme.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusPill)),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorScheme.primary, width: borderThick),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: spacingMd, vertical: 14),
        labelStyle: textTheme.bodyMedium,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.surfaceContainerHighest,
        contentTextStyle: textTheme.bodyMedium,
        shape: shape,
      ),
      extensions: [appColors],
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final base = GoogleFonts.interTextTheme(
      ThemeData(colorScheme: colorScheme, useMaterial3: true).textTheme,
    );
    TextStyle display(TextStyle? s, FontWeight w) =>
        GoogleFonts.barlowCondensed(textStyle: s, fontWeight: w);
    return base.copyWith(
      displaySmall: display(base.displaySmall, FontWeight.w800),
      headlineLarge: display(base.headlineLarge, FontWeight.w800),
      headlineMedium: display(base.headlineMedium, FontWeight.w700),
      headlineSmall: display(base.headlineSmall, FontWeight.w700),
      titleLarge: display(base.titleLarge, FontWeight.w700),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.3),
      labelMedium: base.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
    );
  }
}
