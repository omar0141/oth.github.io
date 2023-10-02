// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:shakosh/constants.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/components/coustom_bottom_nav_bar.dart';
import 'package:shakosh/enums.dart';
import 'package:shakosh/screens/change_password/change_password_screen.dart';
import 'package:shakosh/screens/edit_profile/edit_profile_screen.dart';
import 'package:shakosh/screens/home/home_screen.dart';
import 'package:shakosh/screens/myaddresses/myaddress_screen.dart';
import 'package:provider/provider.dart';
import '../../controller/edit_profile.dart';
import '../../helper/translation.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pushNamed(context, HomeScreen.routeName);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        profieOptions(context, Translation.get("address"),
                            Icons.location_on_outlined, () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Myaddresses(
                              alert: true,
                            );
                          }));
                        }, Colors.black),
                        profieOptions(
                            context,
                            Translation.get("password-change"),
                            Icons.lock_outline, () {
                          Navigator.pushNamed(
                              context, ChangePasswordScreen.routeName);
                        }, Colors.black),
                        profieOptions(context, Translation.get("edit-profile"),
                            Icons.person_outlined, () {
                          Navigator.pushNamed(context, edit_profile.routeName);
                        }, Colors.black),
                        profieOptions(
                            context,
                            Translation.get("delete-account"),
                            Icons.delete_outline, () async {
                          await Provider.of<EditProfileC>(context,
                                  listen: false)
                              .delete_profile(context);
                        }, Colors.red),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomBottomNavBar(
                    selectedMenu: MenuState.profile,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      toolbarHeight: 200,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  Translation.get('profile'),
                  maxLines: 2,
                  style: const TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/images/profile.png',
                    height: 100,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget profieOptions(context, text, icon, tap, color) {
    return InkWell(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(35),
              blurRadius: 5,
              offset: Offset(-1, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 25,
            ),
            SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style:
                  TextStyle(color: color, fontFamily: 'Circular', fontSize: 16),
            )),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
