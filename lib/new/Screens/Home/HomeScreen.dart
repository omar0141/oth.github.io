import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/controller/controllers.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/User/user_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Home/Components/Body.dart';
import 'package:shakosh/new/Screens/Products/ProductSearchMobileScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String routeName = "home";

  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: Body(),
      );
    } else {
      return ScaffoldMobile(
        appBar: myAppBar(context),
        screenName: "home".tr,
        child: Body(),
      );
    }
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: colors(context).whiteColor,
      titleTextStyle: TextStyle(fontFamily: "font-family".tr),
      automaticallyImplyLeading: false,
      title: BlocBuilder<UserBloc,UserState>(
          builder: (context,state) {
          return Row(
            children: [
              Image.asset(logo2,width: 50,height: 50,),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  children: [
                     if (MyApi.username != "")
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                                   "hi".tr +
                                  " " +
                                  (MyApi.username),
                          style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colors(context).kprimaryColor,
                                  fontFamily: "font-family".tr),
                        ))
                      ],
                    ),
                    if (MyApi.username != "")
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "welcome-to-bayt-aleadad".tr,
                          style:
                              TextStyle(color:(MyApi.username != "") ?  colors(context).grey1: colors(context).normalTextColor, fontSize: (MyApi.username != "") ? 14 : 18,
                              fontWeight:(MyApi.username != "") ? FontWeight.normal : FontWeight.bold,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return ProductSearchMobileScreen();
                  }));
                },
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
            ],
          );
        }
      ),
    );
  }
}
