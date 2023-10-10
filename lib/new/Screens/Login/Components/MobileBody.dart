import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Login/Components/LoginForm.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              logo2,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Text(
                      "welcome-to-bayt-aleadad".tr,
                      style: TextStyle(
                          color: colors(context).kprimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                LoginForm(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "sign-in-make-account".tr,
                style: TextStyle(color: colors(context).grey1),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Text("sign-up".tr,
                    style: TextStyle(
                        color: colors(context).kprimaryColor,
                        fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }
}
