import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';

class CarouselContent extends StatelessWidget {
  const CarouselContent(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.currentIndex,
      required this.index});

  final String title;
  final String subTitle;
  final String image;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          currentIndex == index ? title : "",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 17,
        ),
        Text(
          currentIndex == index ? subTitle : "",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 38,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: colors(context).shadowColor!,
                      blurRadius: 20.0,
                      offset: Offset(0.0, 10))
                ],
                borderRadius: BorderRadius.circular(10),
                color: colors(context).onBoardingCardColor),
            child: Image.asset(
              image,
              // width: screenWidth * 0.5,
              // height: screenHeight * 0.55,
            )),
      ],
    );
  }
}
