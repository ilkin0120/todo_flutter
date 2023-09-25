part of './theme.dart';

class ThemeGradients extends ThemeExtension<ThemeGradients> {
  final LinearGradient primary;
  final LinearGradient primaryDisable;

  const ThemeGradients({
    required this.primary,
    required this.primaryDisable,
  });

  @override
  ThemeExtension<ThemeGradients> copyWith(
      {LinearGradient? primary,
      LinearGradient? primaryDisable,
      LinearGradient? translations}) {
    return ThemeGradients(
        primaryDisable: primaryDisable ?? this.primaryDisable,
        primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<ThemeGradients> lerp(
    ThemeExtension<ThemeGradients>? other,
    double t,
  ) {
    if (other is! ThemeGradients) {
      return this;
    }

    return ThemeGradients(
      primary: LinearGradient.lerp(primary, other.primary, t)!,
      primaryDisable:
          LinearGradient.lerp(primaryDisable, other.primaryDisable, t)!,
    );
  }

  static get light => ThemeGradients(
        primary: LightModeColors.gradientPrimary,
        primaryDisable: LightModeColors.gradientPrimaryDisable,
      );
}
