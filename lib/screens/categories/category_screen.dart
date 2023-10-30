import 'package:shakosh/screens/categories/components/body.dart';
import 'package:shakosh/screens/home/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../constants.dart';
import '../../controller/items.dart';
import '../../enums.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = "/category";
  final name;
  final id;
  final image;
  const CategoryScreen({this.name, this.id, this.image, Key? key})
      : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
        return false;
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Body(
                  id: widget.id,
                  image: widget.image,
                )),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomBottomNavBar(
                    selectedMenu: MenuState.home,
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
                flex: 7,
                child: Text(
                  widget.name,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: const TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                  flex: widget.image == null ? 1 : 5,
                  child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
