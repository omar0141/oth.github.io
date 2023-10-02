import 'package:flutter/material.dart';
import 'package:shakosh/screens/splash/splash_screen.dart';
import '../../helper/translation.dart';
import 'components/body.dart';

class PreSignScreen extends StatelessWidget {
  static String routeName = "/pre_sign";

  const PreSignScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          Navigator.pushNamed(context, SplashScreen.routeName);
          return Future.value(false);
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back_sign.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Body(),
          ),
        ));
  }
}
