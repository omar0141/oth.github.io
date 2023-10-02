import 'package:shakosh/helper/translation.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;
  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          SizedBox(
            width: 250,
            height: 250,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 7,
              ),
            ),
          ),
          Text(Translation.get('splash-content'),
              style: TextStyle(
                fontFamily: 'Circular',
                color: Colors.white,
                fontSize: 17,
              ))
        ],
      ),
    );
  }
}
