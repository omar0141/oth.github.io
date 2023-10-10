import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Screens/Login/Components/DesktopBody.dart';
import 'package:shakosh/new/Screens/Login/Components/MobileBody.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String routeName = "login";

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
