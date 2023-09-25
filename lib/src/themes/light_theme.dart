part of './theme.dart';

ThemeData createLightTheme() {
  return ThemeData(
      textTheme: createTextTheme(),
      scaffoldBackgroundColor: LightModeColors.base70,
      extensions: <ThemeExtension<dynamic>>[
        ThemeColors.light,
        ThemeTextStyles.light,
        ThemeGradients.light
      ],
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
      ));
}
