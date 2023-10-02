import 'package:flutter/material.dart';
import '../../helper/translation.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class MyCart extends StatelessWidget {
  static String routeName = "/mycart";

  const MyCart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: const CheckoutCard(),
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
                  Translation.get('cart'),
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
                    'assets/images/cart_screen.png',
                    height: 120,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
