import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/BrandsWidget.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  static String routeName = "brands";

  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: BrandsWidget(),
        ),
      );
    } else {
      return ScaffoldMobile(
        screenName: "brands".tr,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: BrandsWidget(),
        ),
        index: -1,
      );
    }
  }
}
