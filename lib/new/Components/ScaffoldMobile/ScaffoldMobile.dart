import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/Components/MyBottomNavigationBar.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

class ScaffoldMobile extends StatelessWidget {
  const ScaffoldMobile(
      {super.key, required this.child, this.appBar, this.screenName});
  final Widget child;
  final AppBar? appBar;
  final String? screenName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? myAppBar(context, screenName ?? ""),
      body: Container(
        color: colors(context).whiteColor,
        child: ListView(
          children: [
            child,
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

  AppBar myAppBar(BuildContext context, text) {
    return AppBar(
      backgroundColor: colors(context).whiteColor,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: "font-family".tr),
      ),
      leading: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 236, 236),
                borderRadius: BorderRadius.circular(5)),
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: colors(context).normalTextColor,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding:
              const EdgeInsetsDirectional.only(end: 10, top: 10, bottom: 10),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 236, 236),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.search,
                color: colors(context).normalTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
