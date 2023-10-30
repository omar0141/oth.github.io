// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:async';


import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../controller/cart_wishlist.dart';
import '../helper/translation.dart';
import '../screens/details/details_screen.dart';
import '../size_config.dart';


class ProductCard extends StatefulWidget {
  final items;
  final fav;
  final color;
  const ProductCard(this.items, this.fav, this.color);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

int mytime = 4;

class _ProductCardState extends State<ProductCard>
    with TickerProviderStateMixin {
  Timer? t;

  @override
  void initState() {
    () {
      if (widget.items.qty == 0 || widget.items.qty == null) {
        widget.items.end_animation = false;
      } else {
        widget.items.end_animation = true;
      }

      setState(() {});
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.items.featured == '1'
            ? kPrimaryColor
            : Color.fromARGB(255, 224, 245, 255),
      ),
      child: Consumer<Cart>(
        builder: (context, cart, child) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailsScreen(
                  itm_no: widget.items.item_no,
                  itm_name: widget.items.name,
                  price: widget.items.price,
                  item: widget.items,
                );
              }));
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  // color: Color.fromARGB(255, 224, 245, 255),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: getProportionateScreenHeight(150),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container()),
                              ),
                            ),
                            if (widget.items.featured == '1')
                              RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    Translation.get('recommended'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                          ],
                        ),
                        if (widget.items.stock == 0 ||
                            widget.items.stock == null)
                          Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.withOpacity(0.5)),
                            width: double.infinity,
                            height: getProportionateScreenHeight(150),
                            child: Center(
                              child: Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  child: const Text(
                                    'out of stock',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                        CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Colors.white.withOpacity(0),
                          child: Container()                        ),
                        if (widget.items.per_order == '1')
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Text(
                                'Pre-Order',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        // if (widget.items.featured == '1')
                        //   Positioned(
                        //     top: widget.items.per_order == '0' ? 5 : 30,
                        //     right: 5,
                        //     child: Container(
                        //       padding: EdgeInsets.all(5),
                        //       decoration: BoxDecoration(
                        //           color: Colors.blue,
                        //           borderRadius: BorderRadius.only(
                        //               topRight: Radius.circular(
                        //                   widget.items.per_order == '1'
                        //                       ? 0
                        //                       : 10),
                        //               bottomLeft: Radius.circular(10))),
                        //       child: Text(
                        //         'Featured',
                        //         style: TextStyle(
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            '${widget.items.price}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: widget.items.featured == '1'
                                    ? Colors.white
                                    : kPrimaryColor,
                                fontFamily: 'Circular',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' ${Translation.get('le')}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: widget.items.featured == '1'
                                    ? Colors.white
                                    : kPrimaryColor,
                                fontFamily: 'Circular',
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${widget.items.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.w600,
                            color: widget.items.featured == '1'
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${widget.items.unit ?? ''}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            fontFamily: 'Circular',
                                            color: widget.items.featured == '1'
                                                ? Colors.white
                                                : Colors.black45),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Translation.get(
                                                            'language_iso') ==
                                                        'en'
                                                    ? 35
                                                    : 0,
                                                right: Translation.get(
                                                            'language_iso') ==
                                                        'en'
                                                    ? 0
                                                    : 35),
                                            child: GestureDetector(
                                              onTap: () {
                                                widget.items.end_animation =
                                                    false;
                                                try {
                                                  t!.cancel();
                                                } catch (e) {
                                                  debugPrint(e.toString());
                                                }
                                                t = Timer(Duration(seconds: 5),
                                                    () {
                                                  widget.items.end_animation =
                                                      true;
                                                  setState(() {});
                                                });

                                                setState(() {});

                                                if (widget.items.stock != 0 &&
                                                    widget.items.stock !=
                                                        null &&
                                                    widget.items.qty == 0) {
                                                  cart.add(
                                                      widget.items, context);
                                                }
                                              },
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: widget.color,
                                                child: Text(
                                                  widget.items.qty == 0
                                                      ? '+'
                                                      : '${widget.items.qty.toInt()}',
                                                  style: TextStyle(
                                                      fontFamily: 'Circular',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          widget.items.qty == 0
                                                              ? 25
                                                              : 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            Translation.get('add-to-cart'),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Circular',
                                                color:
                                                    widget.items.featured == '1'
                                                        ? Colors.white
                                                        : kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    child: Align(
                                      alignment:
                                          Translation.get('language_iso') ==
                                                  'en'
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 600),
                                        onEnd: () {},
                                        // transform: Matrix4.translationValues(
                                        //     items.qty == 0 ? 180 : 0,
                                        //     items.qty == 0 ? 0 : 0,
                                        //     -1.0),

                                        width: ((widget.items.end_animation ==
                                                        true &&
                                                    widget.items.qty != 0) ||
                                                (widget.items.end_animation ==
                                                        false &&
                                                    widget.items.qty == 0))
                                            ? 0
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                        decoration: BoxDecoration(
                                            color: widget.items.featured == '1'
                                                ? kPrimaryColor
                                                : Color.fromARGB(
                                                    255, 224, 245, 255),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: EdgeInsets.all(10),
                                        child: ((widget.items.end_animation ==
                                                        true &&
                                                    widget.items.qty != 0) ||
                                                (widget.items.end_animation ==
                                                        false &&
                                                    widget.items.qty == 0))
                                            ? Container()
                                            : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cart.remove_qty(
                                                          widget.items,
                                                          context);
                                                      try {
                                                        t!.cancel();
                                                      } catch (e) {
                                                        debugPrint(
                                                            e.toString());
                                                      }
                                                      t = Timer(
                                                          Duration(seconds: 5),
                                                          () {
                                                        if (widget.items.qty ==
                                                            0) {
                                                          widget.items
                                                                  .end_animation =
                                                              false;
                                                        } else {
                                                          widget.items
                                                                  .end_animation =
                                                              true;
                                                        }
                                                        setState(() {});
                                                      });

                                                      setState(() {});
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor:
                                                          widget.color,
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Circular',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.brown
                                                            .withOpacity(0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      '${widget.items.qty.toInt()}',
                                                      style: TextStyle(
                                                          color: widget.items
                                                                      .featured ==
                                                                  '1'
                                                              ? Colors.white
                                                              : Colors.black45,
                                                          fontSize: 17,
                                                          fontFamily:
                                                              'Circular',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (widget.items
                                                              .end_animation ==
                                                          true) {
                                                        widget.items
                                                                .end_animation =
                                                            false;
                                                      }
                                                      if (widget.items.stock !=
                                                              0 &&
                                                          widget.items.stock !=
                                                              null) {
                                                        cart.add(widget.items,
                                                            context);
                                                      }
                                                      try {
                                                        t!.cancel();
                                                      } catch (e) {
                                                        debugPrint(
                                                            e.toString());
                                                      }
                                                      t = Timer(
                                                          Duration(seconds: 5),
                                                          () {
                                                        widget.items
                                                                .end_animation =
                                                            true;
                                                        setState(() {});
                                                      });
                                                      setState(() {});
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor:
                                                          widget.color,
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Circular',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
