import 'package:flutter/material.dart';
import 'package:shakosh/helper/translation.dart';
import 'components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String routeName = "/change_password";

  const ChangePasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Body(),
      ),
    );
  }
}
