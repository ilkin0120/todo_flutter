part of './theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  final TextStyle titleLarge;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  ThemeTextStyles({
    required this.titleLarge,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
  });

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? titleLarge,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
  }) {
    return ThemeTextStyles(
      titleLarge: titleLarge ?? this.titleLarge,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
    );
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }

    return ThemeTextStyles(
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
    );
  }

  static get light => ThemeTextStyles(
        titleLarge: xLargeTextStyle.copyWith(
          color: LightModeColors.base100,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: largeTextStyle.copyWith(
          color: LightModeColors.base100,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: mediumTextStyle.copyWith(
            fontWeight: FontWeight.w400, color: LightModeColors.base100),
        bodySmall: smallTextStyle.copyWith(
          color: LightModeColors.base80,
          fontWeight: FontWeight.w600,
        ),
      );


}
