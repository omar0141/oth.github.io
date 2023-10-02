// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shakosh/screens/cart/cart_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/components/loading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/controller/cart_wishlist.dart';
import 'package:shakosh/helper/translation.dart';
import '../../../controller/categories.dart';
import '../../../controller/items.dart';
import '../../../controller/orders.dart';
import '../../../size_config.dart';
import '../../home/home_screen.dart';
import 'cart_card.dart';
import 'package:shakosh/constants.dart';
import 'package:shakosh/controller/MyApi.dart';

class Body extends StatefulWidget {
  final invo;
  final status;
  final GlobalKey<ScaffoldState> scaffoldkey;
  const Body({Key? key, this.invo, this.status, required this.scaffoldkey})
      : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? branch_id;
  var orders_details;
  getOrders() async {
    await Provider.of<OrdersC>(context, listen: false)
        .getOrdersDetails(widget.invo);
    orders_details =
        Provider.of<OrdersC>(context, listen: false).orders_details;
    setState(() {});
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  int e = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.06, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: Search(
                            list: Provider.of<Getcategories>(context,
                                    listen: false)
                                .gettags));
                  },
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(child: Text('Search')),
                        Container(
                          height: 60,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 241, 241, 241),
                            borderRadius: BorderRadius.only(
                                topRight:
                                    Translation.get('language_iso') == 'ar'
                                        ? Radius.circular(0)
                                        : Radius.circular(50),
                                bottomRight:
                                    Translation.get('language_iso') == 'ar'
                                        ? Radius.circular(0)
                                        : Radius.circular(50),
                                topLeft: Translation.get('language_iso') == 'en'
                                    ? Radius.circular(0)
                                    : Radius.circular(50),
                                bottomLeft:
                                    Translation.get('language_iso') == 'en'
                                        ? Radius.circular(0)
                                        : Radius.circular(50)),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 95, 98, 104),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 209, 209, 209))),
                  ),
                ),
                Consumer<Cart>(builder: (context, mycart, child) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MyCart();
                      }));
                    },
                    child: SizedBox(
                      width: getProportionateScreenWidth(60),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/cart.png',
                            width: 50,
                            height: 50,
                          ),
                          if (mycart.count != 0)
                            Positioned(
                              top: 20,
                              left: Translation.get('language_iso') == 'en'
                                  ? 40
                                  : null,
                              right: Translation.get('language_iso') == 'en'
                                  ? null
                                  : 40,
                              child: Container(
                                height: getProportionateScreenWidth(20),
                                width: getProportionateScreenWidth(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF4848),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1.5, color: Colors.white),
                                ),
                                child: Center(
                                  child: Text(
                                    "${mycart.count}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      height: 1,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          orders_details == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(5)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                Translation.get('order-details'),
                                style: TextStyle(
                                    fontFamily: 'Circular',
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            for (var i = 0;
                                i < orders_details['data']['products'].length;
                                i++)
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  "x${orders_details['data']['products'][i]['quantity']}  ${orders_details['data']['products'][i][Translation.get('product-name')]}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: 'Circular',
                                    color: e == i
                                        ? Color.fromARGB(255, 119, 194, 203)
                                        : kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 224, 245, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          child: ListWheelScrollView(
                            children: [
                              for (var i = 0;
                                  i < orders_details['data']['products'].length;
                                  i++)
                                Container(
                                  width: 150,
                                  margin: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: MyApi.public +
                                          orders_details['data']['products'][i]
                                                  ['thumbnail']
                                              .toString(),
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset('assets/images/logo.png'),
                                    ),
                                  ),
                                )
                            ],
                            squeeze: 0.75,
                            onSelectedItemChanged: (i) {
                              e = i;
                              setState(() {});
                            },
                            physics: FixedExtentScrollPhysics(),
                            itemExtent: 200,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${orders_details['data']['products'][e]['price']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontFamily: 'Circular',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' ${Translation.get('le')}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontFamily: 'Circular',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                '${orders_details['data']['products'][e][Translation.get('product-name')]}',
                                style: const TextStyle(
                                    fontFamily: 'Circular',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${orders_details['data']['products'][e]['unit-measure']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Circular',
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  )),
          widget.status != 'canceled' && widget.status != 'delivered'
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Row(
                    children: [
                      widget.status == 'processing' ||
                              widget.status == 'shipping' ||
                              widget.status == 'arrived'
                          ? Selected()
                          : notSelected(),
                      widget.status == 'shipping' || widget.status == 'arrived'
                          ? Expanded(
                              child: Container(
                                height: 5,
                                color: kPrimaryColor,
                              ),
                            )
                          : Expanded(
                              child: Container(
                                height: 5,
                                color: Colors.grey,
                              ),
                            ),
                      // dottedLine(),
                      widget.status == 'shipping' || widget.status == 'arrived'
                          ? Selected()
                          : notSelected(),
                      widget.status == 'arrived'
                          ? Expanded(
                              child: Container(
                                height: 5,
                                color: kPrimaryColor,
                              ),
                            )
                          : Expanded(
                              child: Container(
                                height: 5,
                                color: Colors.grey,
                              ),
                            ),
                      // dottedLine(),
                      widget.status == 'arrived' ? Selected() : notSelected(),
                    ],
                  ),
                )
              : Container(),
          widget.status != 'canceled' && widget.status != 'delivered'
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.get('processing'),
                        style: TextStyle(
                            color: widget.status == 'processing' ||
                                    widget.status == 'shipping' ||
                                    widget.status == 'arrived'
                                ? kPrimaryColor
                                : Colors.grey,
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Translation.get('shipping'),
                        style: TextStyle(
                            color: widget.status == 'shipping' ||
                                    widget.status == 'arrived'
                                ? kPrimaryColor
                                : Colors.grey,
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Translation.get('arrived'),
                        style: TextStyle(
                            color: widget.status == 'arrived'
                                ? kPrimaryColor
                                : Colors.grey,
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : Container(),
          widget.status != 'canceled' && widget.status != 'delivered'
              ? SizedBox(
                  height: 20,
                )
              : Container(),
        ],
      ),
    );
  }

  CircleAvatar Selected() {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      radius: 10,
      child: Container(),
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
      backgroundColor: Colors.grey,
      radius: 10,
      child: Container(),
    );
  }
}
