part of './theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color green100;
  final Color blue100;
  final Color background;
  final Color primaryTextColor;
  final Color grey100;

  const ThemeColors({
    required this.green100,
    required this.blue100,
    required this.background,
    required this.primaryTextColor,
    required this.grey100,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? green100,
    Color? blue100,
    Color? background,
    Color? primaryTextColor,
    Color? grey100,
  }) {
    return ThemeColors(
      green100: green100 ?? this.green100,
      blue100: blue100 ?? this.blue100,
      background: background ?? this.background,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      grey100: grey100 ?? this.grey100,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      green100: Color.lerp(green100, other.green100, t)!,
      blue100: Color.lerp(blue100, other.blue100, t)!,
      background: Color.lerp(background, other.background, t)!,
      primaryTextColor:
          Color.lerp(primaryTextColor, other.primaryTextColor, t)!,
      grey100: Color.lerp(grey100, other.grey100, t)!,
    );
  }

  static get light => const ThemeColors(
      background: LightModeColors.base70,
      blue100: LightModeColors.blue100,
      green100: LightModeColors.green100,
      grey100: LightModeColors.base80,
      primaryTextColor: LightModeColors.base100);
}
