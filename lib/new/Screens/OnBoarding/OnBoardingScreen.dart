import 'package:flutter/material.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Screens/OnBoarding/Components/Body.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  static String routeName = "/OnBoarding";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(onBoardingBackground), fit: BoxFit.cover)),
          child: Body()),
    );
  }
}
