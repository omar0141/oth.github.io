import 'package:flutter/widgets.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Favourite/Components/Body.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  static String routeName = "favourite";

  @override
    Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: Body(),
      );
    } else {
      return ScaffoldMobile(
        screenName: "favourite".tr,
        child: Body(),
        index: 2,
      );
    }
  }
}