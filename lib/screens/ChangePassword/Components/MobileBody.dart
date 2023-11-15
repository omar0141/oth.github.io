import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Config/Images/Images.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Screens/ChangePassword/Components/ChangePasswordForm.dart';

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
              width: 100,
              height: 100,
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
                      "welcome-to-bayt-aleadad".tr,
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
                ChangePasswordForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
