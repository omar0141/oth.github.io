import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shakosh/new/Config/Colors/AppColors.dart';
import 'package:shakosh/new/Config/Colors/ColorPalette.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/NoTransitionBuilder.dart';

ThemeData myTheme() {
  return ThemeData(
      fontFamily: "font-family".tr,
      appBarTheme: appBarTheme(),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          for (final platform in TargetPlatform.values)
            platform: const NoTransitionsBuilder(),
        },
      ),
      primarySwatch: ColorPalette.primaryLight,
      brightness: Brightness.light,
      inputDecorationTheme: inputDecorationTheme(),
      extensions: <ThemeExtension<AppColors>>[
        AppColors(
            black2: Colors.black,
            grey1: Colors.grey,
            grey2: Color.fromARGB(255, 214, 214, 214),
            kprimaryColor: Color.fromARGB(255, 58, 58, 58),
            kSecondaryColor: Color.fromARGB(255, 77, 120, 163),
            onBoardingCardColor: Color.fromRGBO(231, 232, 233, 1),
            whiteColor: Color.fromRGBO(250, 250, 250, 1),
            shadowColor: Color.fromARGB(255, 235, 235, 235),
            hoverColor: Color.fromARGB(255, 97, 97, 97).withOpacity(0.5),
            normalTextColor: Colors.black,
            normalTextColor2: Color.fromARGB(255, 94, 94, 94),
            normalTextColor3: Color.fromARGB(255, 94, 94, 94),
            cancelColor: Color.fromRGBO(255, 105, 138, 1),
            popUpMenuColor: Colors.white),
      ]);
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(2.5),
    borderSide: BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
    gapPadding: 5,
  );
  OutlineInputBorder foucsInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(2.5),
    borderSide: const BorderSide(color: Colors.black),
    gapPadding: 5,
  );
  return InputDecorationTheme(
    // floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: foucsInputBorder,
    border: outlineInputBorder,

    floatingLabelStyle: TextStyle(color: Colors.black),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    toolbarTextStyle: TextTheme(
      titleLarge: TextStyle(fontSize: 18),
    ).bodyMedium,
    titleTextStyle: TextTheme(
      titleLarge: TextStyle(fontSize: 18),
    ).titleLarge,
  );
}
