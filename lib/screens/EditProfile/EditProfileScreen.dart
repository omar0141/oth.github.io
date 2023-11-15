import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/Screens/EditProfile/Components/DesktopBody.dart';
import 'package:shakosh/Screens/EditProfile/Components/MobileBody.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  static String routeName = "EditProfile";

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
