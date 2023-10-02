import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/OnBoarding/Components/CarouselContent.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: screenHeight * 0.6,
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.4,
              color: colors(context).kprimaryColor,
            ),
          ],
        ),
        Positioned.fill(
            child: Column(
          children: [
            carousel(),
            buildDotIndicator(context, 3),
            SizedBox(
              height: 30,
            ),
            shoppingButton(context)
          ],
        ))
      ],
    );
  }

  MaterialButton shoppingButton(BuildContext context) {
    return MaterialButton(
      color: currentPage == 2
          ? Color.fromRGBO(186, 152, 176, 1)
          : Color.fromRGBO(196, 166, 185, 1),
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: colors(context).whiteColor!)),
      onPressed: () {},
      child: Text(
        "shopping-now".tr,
        style: TextStyle(
            color: colors(context).whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  CarouselSlider carousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight * 0.8,
        enableInfiniteScroll: false,
        initialPage: currentPage,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        viewportFraction: 0.72,
        onPageChanged: (index, reason) {
          currentPage = index;
          setState(() {});
        },
      ),
      items: [
        CarouselContent(
          title: "discover-something-new".tr,
          subTitle: "special-new-arrivals-just-for-you".tr,
          image: onBoarding1,
          index: 0,
          currentIndex: currentPage,
        ),
        CarouselContent(
          title: "update-trendy-outfit".tr,
          subTitle: "favorite-brands-and-hottest-trends".tr,
          image: onBoarding2,
          index: 1,
          currentIndex: currentPage,
        ),
        CarouselContent(
          title: "explore-your-true-style".tr,
          subTitle: "relax-and-let-us-bring-the-style-to-you".tr,
          image: onBoarding3,
          index: 2,
          currentIndex: currentPage,
        )
      ],
    );
  }

  Widget buildDotIndicator(BuildContext context, int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < length; index++)
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.only(right: 5),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
                color: currentPage == index ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white)),
          ),
      ],
    );
  }
}
