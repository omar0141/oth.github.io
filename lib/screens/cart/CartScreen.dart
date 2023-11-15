import 'package:flutter/widgets.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Screens/Cart/Components/Body.dart';
import 'package:shakosh/Screens/Cart/Components/TotalCartWidget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return Body();
    } else {
      return ScaffoldMobile(
        screenName: "cart".tr,
        child: Body(),
        bottomNavigationBar: TotalCartWidget(),
        index: 1,
      );
    }
  }
}
