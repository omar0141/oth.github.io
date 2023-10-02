import 'package:flutter/material.dart';
import 'package:shakosh/screens/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../helper/translation.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Translation.get('sign-in-make-account'),
          style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: Color.fromARGB(255, 120, 161, 233)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
          child: Text(
            Translation.get('sign-in'),
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16), color: Colors.white),
          ),
        ),
      ],
    );
  }
}
