import 'package:flutter/material.dart';
import 'package:shakosh/components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../helper/translation.dart';
import '../home/home_screen.dart';
import 'components/body.dart';

class Favourite extends StatelessWidget {
  static String routeName = "/favourite";

  const Favourite({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(child: Body()),
                SizedBox(
                  height: 60,
                )
              ],
            ),
            Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomBottomNavBar(
                    selectedMenu: MenuState.favourite,
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
                      Navigator.of(context).pop();
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
                  Translation.get('favourite'),
                  maxLines: 2,
                  style: const TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                  flex: 2, child: Image.asset('assets/images/favourite.png')),
            ],
          ),
        ],
      ),
    );
  }
}
