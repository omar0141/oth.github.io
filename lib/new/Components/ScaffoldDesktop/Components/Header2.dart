import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

class Header2 extends StatelessWidget {
  const Header2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colors(context).black2,
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  buildMenuItem(context, "home".tr, () {}),
                  buildMenuItem(context, "categories".tr, () {}),
                  buildMenuItem(context, "brands".tr, () {}),
                  buildMenuItem(context, "about-us".tr, () {}),
                  buildMenuItem(context, "contact-us".tr, () {}),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                tooltip: "cart".tr,
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.cartShopping,
                  color: colors(context).whiteColor,
                )),
            SizedBox(
              width: 5,
            ),
            Tooltip(
              message: "profile".tr,
              child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: colors(context).whiteColor,
                        size: 28,
                      ),
                      Icon(
                        FontAwesomeIcons.solidCircleUser,
                        color: colors(context).whiteColor,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            languageButton(context),
            SizedBox(
              width: 20,
            ),
          ],
        ));
  }

  Widget languageButton(context) {
    return PopupMenuButton(
      child: Tooltip(
        message: "language".tr,
        child: Row(
          children: [
            // Text(
            //   "language".tr,
            //   style: TextStyle(
            //       color: colors(context).whiteColor, fontSize: 18, height: 1),
            // ),
            // SizedBox(
            //   width: 7,
            // ),
            Image.asset(
              "language_iso".tr == "ar" ? egypt : unitedKingdom,
              width: 35,
              height: 35,
            )
          ],
        ),
      ),
      position: PopupMenuPosition.under,
      padding: EdgeInsets.only(top: -10),
      tooltip: "",
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Image.asset(
                unitedKingdom,
                width: 25,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "English",
                style: TextStyle(color: colors(context).normalTextColor2),
              ),
            ],
          ),
          onTap: () async {
            await Translations.setLocale("en");
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Image.asset(
                egypt,
                width: 25,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "العربية",
                style: TextStyle(color: colors(context).normalTextColor2),
              ),
            ],
          ),
          onTap: () async {
            await Translations.setLocale("ar");
          },
        ),
      ],
    );
  }

  Padding buildMenuItem(context, text, press) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          hoverColor: colors(context).hoverColor,
          onTap: press,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Text(
              text,
              style: TextStyle(color: colors(context).whiteColor, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
