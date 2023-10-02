// ignore_for_file: camel_case_types

import 'package:shakosh/screens/home/home_screen.dart';
import 'package:shakosh/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/helper/translation.dart';
import 'components/body.dart';

class edit_profile extends StatelessWidget {
  static String routeName = "/edit_profile";

  const edit_profile({Key? key}) : super(key: key);
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
