import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/Screens/Register/Components/DesktopBody.dart';
import 'package:shakosh/Screens/Register/Components/MobileBody.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static String routeName = "register";

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
