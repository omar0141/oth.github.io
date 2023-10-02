// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shakosh/components/coustom_bottom_nav_bar.dart';
import 'package:flutter/widgets.dart';
import '../../enums.dart';
import '../../helper/translation.dart';
import '../cart/cart_screen.dart';
import 'components/body.dart';

class Orders2Screen extends StatefulWidget {
  final myinvo;
  final status;
  const Orders2Screen({Key? key, this.myinvo, this.status}) : super(key: key);

  @override
  State<Orders2Screen> createState() => _Orders2ScreenState();
}

class _Orders2ScreenState extends State<Orders2Screen> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Body(
                  invo: widget.myinvo,
                  status: widget.status,
                  scaffoldkey: scaffoldkey,
                ),
              ),
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
                  selectedMenu: MenuState.chat,
                ),
              ))
        ],
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
                  Translation.get('orders-status'),
                  maxLines: 2,
                  style: const TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Image.asset('assets/images/order_details.png')),
            ],
          ),
        ],
      ),
    );
  }
}
