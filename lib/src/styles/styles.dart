part of '../themes/theme.dart';

const xLargeTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 24);
const largeTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 17);
const mediumTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 15);
const smallTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 13);

class LightModeColors {
  static const primary60 = Color(0xFFD0F5F5);
  static const primary10 = Color(0xFFE5FAFA);

  static const green100 = Color(0xFF34A854);
  static const red100 = Color(0xFFF04F4F);
  static const blue100 = Color(0xFF4285F4);

  static const base100 = Color(0xFF2B2D33);
  static const base80 = Color(0xFF92959D);
  static const base70 = Color(0xFFDCDDDF);

  static LinearGradient gradientPrimary = const LinearGradient(
      colors: [Color(0xFF17AFAE), Color(0xFF35DB67)],
      stops: [0, 1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static LinearGradient gradientPrimaryDisable = const LinearGradient(
      colors: [Color(0xFF7ECACA), Color(0xFF8DE0A7)],
      stops: [0.16, 0.83],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
