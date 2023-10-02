// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shakosh/constants.dart';
import 'package:shakosh/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/screens/orders/orders_screen.dart';
import '../../../controller/orders.dart';
import '../../../helper/translation.dart';
import 'package:shakosh/screens/orderitems/orders2_screen.dart';

class CartCard extends StatelessWidget {
  const CartCard(
      {Key? key,
      required this.invo,
      this.date,
      this.total,
      this.statue,
      this.color})
      : super(key: key);
  final invo;
  final date;
  final total;
  final statue;
  final color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Orders2Screen(
              myinvo: invo,
              status: statue,
            );
          }));
        },
        child: Card(
          elevation: 3,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   side: BorderSide(
          //       color: statue == 'canceled' ? Colors.red : color, width: 2.0),
          // ),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/images/logo.png'))),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        children: [
                          Text(
                            statue,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: statue == 'canceled'
                                    ? Colors.red
                                    : statue == 'delivered'
                                        ? Colors.green
                                        : kPrimaryColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Text(
                            '${Translation.get('order-num')} : $invo',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Text(
                            '${Translation.get('order-date')} : $date',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Text(
                            '${Translation.get('order-total')} : $total',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    statue == 'processing'
                        ? Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        Translation.get('cancel'),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                )),
          ]),
        ));
  }

  CircleAvatar Selected() {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      radius: 10,
      child: Icon(
        Icons.done,
        size: 15,
      ),
    );
  }

  SizedBox dottedLine() {
    return SizedBox(
      width: getProportionateScreenWidth(85),
      child: Row(
        children: List.generate(
            350 ~/ 10,
            (index) => Expanded(
                  child: Container(
                    color: index % 2 == 0 ? Colors.transparent : kPrimaryColor,
                    height: 2,
                  ),
                )),
      ),
    );
  }

  CircleAvatar notSelected() {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 10,
      child: Icon(
        Icons.circle_outlined,
        size: 25,
        color: kPrimaryColor,
      ),
    );
  }
}
