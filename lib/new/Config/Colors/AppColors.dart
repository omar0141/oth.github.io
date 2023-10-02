import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? kprimaryColor;
  final Color? kSecondaryColor;
  final Color? onBoardingCardColor;
  final Color? whiteColor;
  final Color? shadowColor;
  final Color? hoverColor;
  final Color? normalTextColor;
  final Color? normalTextColor2;
  final Color? normalTextColor3;
  final Color? cancelColor;
  final Color? popUpMenuColor;
  final Color? grey1;
  final Color? grey2;
  final Color? black2;

  const AppColors({
    required this.kprimaryColor,
    required this.kSecondaryColor,
    required this.onBoardingCardColor,
    required this.whiteColor,
    required this.shadowColor,
    required this.hoverColor,
    required this.normalTextColor,
    required this.normalTextColor2,
    required this.normalTextColor3,
    required this.cancelColor,
    required this.popUpMenuColor,
    required this.grey1,
    required this.grey2,
    required this.black2,
  });

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      kprimaryColor: Color.lerp(kprimaryColor, other.kprimaryColor, t),
      kSecondaryColor: Color.lerp(kSecondaryColor, other.kSecondaryColor, t),
      onBoardingCardColor:
          Color.lerp(onBoardingCardColor, other.onBoardingCardColor, t),
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t),
      normalTextColor: Color.lerp(normalTextColor, other.normalTextColor, t),
      normalTextColor2: Color.lerp(normalTextColor2, other.normalTextColor2, t),
      normalTextColor3: Color.lerp(normalTextColor3, other.normalTextColor3, t),
      cancelColor: Color.lerp(cancelColor, other.cancelColor, t),
      popUpMenuColor: Color.lerp(popUpMenuColor, other.popUpMenuColor, t),
      grey1: Color.lerp(grey1, other.grey1, t),
      grey2: Color.lerp(grey2, other.grey2, t),
      black2: Color.lerp(black2, other.black2, t),
    );
  }

  @override
  ThemeExtension<AppColors> copyWith() {
    throw UnimplementedError();
  }
}
