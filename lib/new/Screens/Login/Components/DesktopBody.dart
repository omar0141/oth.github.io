import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Login/Components/LoginForm.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.73,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Container(
                  padding:
                      EdgeInsets.only(right: 15, left: 15, top: 30, bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 1, color: colors(context).grey2!)),
                  width: 400,
                  child: Column(
                    children: [
                      LoginForm(),
                      SizedBox(
                        height: 25,
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
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
