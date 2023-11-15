import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/Screens/ChangePassword/Components/DesktopBody.dart';
import 'package:shakosh/Screens/ChangePassword/Components/MobileBody.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  static String routeName = "ChangePassword";

  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: DesktopBody(),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          body: MobileBody(),
        ),
      );
    }
  }
}
