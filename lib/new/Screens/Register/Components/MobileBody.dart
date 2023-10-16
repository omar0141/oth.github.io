import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Login/LoginScreen.dart';
import 'package:shakosh/new/Screens/Register/Components/RegisterForm.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 236, 236, 236),
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.arrow_back,
                    size: 22,
                    color: colors(context).normalTextColor,
                  ),
                ),
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              logo2,
              width: 85,
              height: 85,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Text(
                      "register-now".tr,
                      style: TextStyle(
                          color: colors(context).kprimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RegisterForm(),
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
                "already-have".tr,
                style: TextStyle(color: colors(context).grey1),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Text("sign-in".tr,
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
