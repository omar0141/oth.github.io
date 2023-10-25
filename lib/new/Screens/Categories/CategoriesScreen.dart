import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Categories/Components/Body.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key, this.categoryId});
  String? categoryId;
  static String routeName = "categories/:id";



  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: Body(
          categoryId: categoryId,
        ),
      );
    } else {
      return ScaffoldMobile(
        screenName: "categories".tr,
        child: Body(
          categoryId: categoryId,
        ),
        index: -1,
      );
    }
  }
}
