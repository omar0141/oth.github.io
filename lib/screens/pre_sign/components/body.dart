// ignore_for_file: prefer_const_constructors

import 'package:shakosh/components/no_account_text.dart';
import 'package:shakosh/constants.dart';
import 'package:shakosh/helper/translation.dart';
import 'package:shakosh/screens/sign_in/sign_in_screen.dart';
import 'package:shakosh/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import '../../../controller/social_auth.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.3),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: kPrimaryColor,
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.1,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Translation.get('welcome'),
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Circular'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  Translation.get('manage-your-expenses'),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Circular',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  Translation.get('seamlessly-intuitively'),
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Circular',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                if (Platform.isIOS)
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: (() async {
                      await Provider.of<SocialAuth>(context, listen: false)
                          .signInWithApple(
                              context, '', '', '', '', '', '', '', false, true);
                    }),
                    icon: Icon(
                      FontAwesomeIcons.apple,
                      color: Colors.black,
                      size: 16,
                    ),
                    label: Text(
                      Translation.get('sign-in-with-apple'),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Circular',
                          fontSize: 17),
                    ),
                  ),
                if (Platform.isIOS) SizedBox(height: 5),
                if (Platform.isAndroid)
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: (() async {
                      await Provider.of<SocialAuth>(context, listen: false)
                          .signInWithGoogle(
                              context, '', '', '', '', '', '', '', false, true);
                    }),
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: kPrimaryColor,
                      size: 16,
                    ),
                    label: Text(
                      Translation.get('sign-in-with-google'),
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'Circular',
                          fontSize: 17),
                    ),
                  ),
                if (Platform.isAndroid) SizedBox(height: 5),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: (() async {
                    await Provider.of<SocialAuth>(context, listen: false)
                        .signInWithFacebook(
                            context, '', '', '', '', '', '', '', false, true);
                  }),
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    color: kPrimaryColor,
                    size: 16,
                  ),
                  label: Text(
                    Translation.get('sign-in-with-facebook'),
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Circular',
                        fontSize: 17),
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: (() async {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  }),
                  child: Text(
                    Translation.get('creat-account'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Circular',
                        fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                NoAccountText(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
