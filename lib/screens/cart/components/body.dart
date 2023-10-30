// ignore_for_file: prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shakosh/helper/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/screens/details/details_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

import '../../../size_config.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/controller/cart_wishlist.dart';
import 'package:shakosh/models/Item.dart';
import 'package:shakosh/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
        child: Consumer<Cart>(builder: (context, cart, child) {
          return ListView.builder(
              itemCount: cart.basket.length,
              itemBuilder: (context, i) {
                double tax = 0;
                if (cart.basket[i]!.equation != null) {
                  Parser p = Parser();
                  String newtax = cart.basket[i]!.equation!.replaceAll('x',
                      '${cart.basket[i]!.discount_price == 0 ? cart.basket[i]!.price : cart.basket[i]!.discount_price! * cart.basket[i]!.multiplier!}');
                  tax = p
                      .parse(newtax)
                      .evaluate(EvaluationType.REAL, ContextModel());
                } else {
                  tax = 0;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                      elevation: 3,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: cart.myitems[i]!.error == true
                                  ? Colors.red
                                  : Colors.transparent,
                              width: 1),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DetailsScreen(
                                        itm_no: cart.basket[i]!.item_no,
                                        itm_name: cart.basket[i]!.name,
                                        price: cart.basket[i]!.price,
                                        item: cart.basket[i],
                                      );
                                    }));
                                  },
                                  child: Container())),
                          SizedBox(width: 20),
                          Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart.basket[i]!.name!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 15,
                                          backgroundColor: kPrimaryColor,
                                          child: IconButton(
                                            iconSize: 15,
                                            icon: Icon(Icons.add),
                                            color: Colors.white,
                                            onPressed: () {
                                              cart.add(cart.basket[i], context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Text(cart.basket[i]!.qty
                                              .toStringAsFixed(0)),
                                        ),
                                        CircleAvatar(
                                          maxRadius: 15,
                                          backgroundColor: Colors.grey[300],
                                          child: IconButton(
                                            icon: Icon(Icons.remove),
                                            color: Colors.white,
                                            iconSize: 15,
                                            onPressed: () {
                                              cart.remove_qty(
                                                  cart.basket[i], context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${cart.basket[i]!.price! + tax}EGP',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor),
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  title: Translation.get(
                                      'cart-delete-item-message'),
                                  btnOkOnPress: () {
                                    cart.remove(cart.basket[i], context);
                                  },
                                ).show();

                                // AwesomeDialog(
                                //   context: context,
                                //   dialogType: DialogType.SUCCES,
                                //   title: Translation.get("success"),
                                //   desc: Translation.get("address-success"),
                                //   btnOkColor: Colors.green,
                                //   btnOkText: Translation.get("ok"),
                                //   btnOkOnPress: () {
                                //     Navigator.pushNamed(
                                //         context, Myaddresses.routeName);
                                //   },
                                // ).show();
                                //  cart.remove(cart.basket[i], context);
                              },
                              child: Icon(
                                FontAwesomeIcons.trashAlt,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          )
                        ],
                      )),
                );
              });
        }));
  }
}
