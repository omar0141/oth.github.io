import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/User/user_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Components/dialogs.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/new/Screens/Brands/BrandsScreen.dart';
import 'package:shakosh/new/Screens/ChangePassword/ChangePasswordScreen.dart';
import 'package:shakosh/new/Screens/EditProfile/EditProfileScreen.dart';
import 'package:shakosh/new/Screens/Login/LoginScreen.dart';
import 'package:shakosh/new/Screens/Orders/OrdersScreen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  static String routeName = "more";

  @override
  Widget build(BuildContext context) {
    return ScaffoldMobile(
        screenName: "more".tr,
        index: 3,
        child: Column(
          children: [
            buildMenuItem(Icons.list, "categories".tr, () {
              Navigator.of(context).pushNamed("categories");
            }, context),
            buildMenuItem(Icons.local_offer, "brands".tr, () {
              Navigator.of(context).pushNamed(BrandsScreen.routeName);
            }, context),
            buildMenuItem(Icons.person, "edit-profile".tr, () {
              if (MyApi.UID != "")
                Navigator.of(context).pushNamed(EditProfileScreen.routeName);
              else
                loginDialog();
            }, context),
            buildMenuItem(Icons.lock, "password-change".tr, () {
              if (MyApi.UID != "")
                Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
              else
                loginDialog();
            }, context),
            buildMenuItem(Icons.local_shipping, "my-orders".tr, () {
              if (MyApi.UID != "")
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              else
                loginDialog();
            }, context),
            buildMenuItem(MyApi.UID != "" ? Icons.logout : Icons.login,
                MyApi.UID != "" ? "logout".tr : "sign-in".tr, () {
              if (MyApi.UID != "") {
                BlocProvider.of<UserBloc>(navigatorKey.currentContext!).logout();
              } else {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }
            }, context, color: MyApi.UID != "" ? Colors.red : null),
          ],
        ));
  }

  Widget buildMenuItem(icon, text, press, context, {Color? color}) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 236, 236, 236)),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? colors(context).normalTextColor!.withOpacity(0.7),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                style: TextStyle(
                    color: color ??
                        colors(context).normalTextColor!.withOpacity(0.7),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  void loginDialog() {
    MyDialogs().showdialog(
        navigatorKey.currentContext!,
        DialogType.infoReverse,
        mySize(screenWidth * 0.95, screenWidth * 0.95, 400, 400, 400),
        "you-need-to-sign-in-first".tr,
        "sorry".tr, () {
      Navigator.of(navigatorKey.currentContext!)
          .pushNamed(LoginScreen.routeName);
    }, null, buttonOkText: "sign-in".tr);
  }
}
