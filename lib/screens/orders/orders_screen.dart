// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shakosh/controller/orders.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/helper/translation.dart';
import 'package:shakosh/screens/home/home_screen.dart';
import 'package:shakosh/size_config.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../controller/cart_wishlist.dart';
import '../../controller/categories.dart';
import '../../enums.dart';
import '../cart/cart_screen.dart';
import 'components/cart_card.dart';
import 'package:shakosh/constants.dart';

class OrdersScreen extends StatefulWidget {
  static String routeName = "/order";

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool accept = false;
  bool refuse = false;
  var orders;
  getOrders() async {
    await Provider.of<OrdersC>(context, listen: false).getorders();
    orders = Provider.of<OrdersC>(context, listen: false).orders;
    setState(() {});
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: orders == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(5)),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      top: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showSearch(
                                              context: context,
                                              delegate: Search(
                                                  list: Provider.of<
                                                              Getcategories>(
                                                          context,
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Translation.get(
                                                                  'language_iso') ==
                                                              'ar'
                                                          ? Radius.circular(0)
                                                          : Radius.circular(50),
                                                      bottomRight: Translation.get(
                                                                  'language_iso') ==
                                                              'ar'
                                                          ? Radius.circular(0)
                                                          : Radius.circular(50),
                                                      topLeft: Translation.get(
                                                                  'language_iso') ==
                                                              'en'
                                                          ? Radius.circular(0)
                                                          : Radius.circular(50),
                                                      bottomLeft: Translation.get(
                                                                  'language_iso') ==
                                                              'en'
                                                          ? Radius.circular(0)
                                                          : Radius.circular(
                                                              50)),
                                                ),
                                                child: Icon(
                                                  Icons.search,
                                                  color: Color.fromARGB(
                                                      255, 95, 98, 104),
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 209, 209, 209))),
                                        ),
                                      ),
                                      Consumer<Cart>(
                                          builder: (context, mycart, child) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return MyCart();
                                            }));
                                          },
                                          child: SizedBox(
                                            width:
                                                getProportionateScreenWidth(60),
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
                                                    left: Translation.get(
                                                                'language_iso') ==
                                                            'en'
                                                        ? 40
                                                        : null,
                                                    right: Translation.get(
                                                                'language_iso') ==
                                                            'en'
                                                        ? null
                                                        : 40,
                                                    child: Container(
                                                      height:
                                                          getProportionateScreenWidth(
                                                              20),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              20),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFFF4848),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "${mycart.count}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            height: 1,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: orders['data'].length,
                                    itemBuilder: (context, i) {
                                      return Column(children: [
                                        CartCard(
                                          invo: orders['data'][i]['id']
                                              .toString(),
                                          date: orders['data'][i]['addstamp']
                                              .toString(),
                                          total: orders['data'][i]
                                                  ['total_amount']
                                              .toString(),
                                          statue: orders['data'][i]['status']
                                              .toString(),
                                          color: kPrimaryColor,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ]);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomBottomNavBar(
                          selectedMenu: MenuState.orders,
                        ),
                      ))
                ],
              ),
      ),
    );
  }
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
                Translation.get("orders-status"),
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(
                flex: 5, child: Image.asset('assets/images/order_details.png')),
          ],
        ),
      ],
    ),
  );
}
