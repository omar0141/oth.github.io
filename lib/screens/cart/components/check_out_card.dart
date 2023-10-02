// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shakosh/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/constants.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/components/default_button.dart';
import 'package:shakosh/controller/cart_wishlist.dart';
import 'package:shakosh/screens/home/home_screen.dart';
import '../../../components/loading.dart';
import '../../../controller/Address.dart';
import '../../../controller/categories.dart';
import '../../../controller/checkout.dart';
import '../../../controller/dependants.dart';
import '../../../controller/items.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';
import 'package:intl/intl.dart';
import '../../sign_in/sign_in_screen.dart';
import 'package:math_expressions/math_expressions.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  int? val = 0;
  DateTime? mydate;
  String? selected_address;
  String? selected_branch;
  String? selected_payment;
  String? selected_payment_code;
  TextEditingController coupon = TextEditingController();
  GlobalKey<FormState> formcheckout = GlobalKey();
  String? coupon_name = '';
  Expression? exp;
  double net = 0;
  double endtotal = 0;
  bool shipping_calc = false;
  late var taxes;
  final format = DateFormat("yyyy-MM-dd HH:mm");

  checkout(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, mysetState) {
            return AlertDialog(
                scrollable: true,
                content: Form(
                  key: formcheckout,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: val,
                            onChanged: (dynamic value) {
                              mysetState(() {
                                val = value;
                                selected_branch = null;
                                selected_payment = Provider.of<GetDependants>(
                                        context,
                                        listen: false)
                                    .payments[0]
                                    .id
                                    .toString();
                              });
                            },
                            activeColor: kPrimaryColor,
                          ),
                          Text(Translation.get('delivery')),
                          SizedBox(
                            width: 10,
                          ),
                          Radio(
                            value: 1,
                            groupValue: val,
                            onChanged: (dynamic value) {
                              mysetState(() {
                                val = value;
                                selected_address = null;
                                selected_payment = Provider.of<GetDependants>(
                                        context,
                                        listen: false)
                                    .payments[0]
                                    .id
                                    .toString();
                              });
                            },
                            activeColor: kPrimaryColor,
                          ),
                          Text(Translation.get('pick-up')),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        onChanged: (dynamic value) {
                          selected_payment = value;
                          int index = Provider.of<GetDependants>(context,
                                  listen: false)
                              .payments
                              .indexWhere((element) =>
                                  element.id.toString() == value.toString());
                          selected_payment_code =
                              Provider.of<GetDependants>(context, listen: false)
                                  .payments[index]
                                  .id;
                          debugPrint(value.toString());
                        },
                        value: selected_payment,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: Translation.get('payment'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        items:
                            Provider.of<GetDependants>(context, listen: false)
                                .payments
                                .map((data) {
                          return DropdownMenuItem<String>(
                            value: data.id.toString(),
                            child: Text(
                              data.name.toString(),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: coupon,
                        decoration: InputDecoration(
                          labelText: Translation.get("coupon"),
                          hintText: Translation.get("enter-coupon"),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          labelStyle: TextStyle(color: kPrimaryColor),
                        ),
                        onChanged: (e) {
                          int i =
                              Provider.of<GetDependants>(context, listen: false)
                                  .search_coupons(e);
                          if (i == -1) {
                            coupon_name = '';
                            if (exp != null) {
                              Provider.of<Cart>(context, listen: false)
                                      .myendtotal =
                                  Provider.of<Cart>(context, listen: false)
                                          .myendtotal -
                                      exp!.evaluate(
                                          EvaluationType.REAL, ContextModel());
                              exp = null;
                            }
                          } else {
                            if (exp == null) {
                              coupon_name = Provider.of<GetDependants>(context,
                                      listen: false)
                                  .coupons[i]
                                  .name;
                              String mycoupon = Provider.of<GetDependants>(
                                      context,
                                      listen: false)
                                  .coupons[i]
                                  .discount_equation!;
                              var endtotal =
                                  Provider.of<Cart>(context, listen: false)
                                      .myendtotal;
                              Parser p = Parser();
                              String newcoupoun =
                                  mycoupon.replaceAll('x', '$endtotal');
                              exp = p.parse(newcoupoun);
                              Provider.of<Cart>(context, listen: false)
                                      .myendtotal =
                                  endtotal +
                                      exp!.evaluate(
                                          EvaluationType.REAL, ContextModel());
                              debugPrint((endtotal +
                                      exp!.evaluate(
                                          EvaluationType.REAL, ContextModel()))
                                  .toString());
                            }
                          }
                          mysetState(() {});
                          setState(() {});
                        },
                      ),
                      coupon_name != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      Text(coupon_name!),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 80,
                        child: DefaultButton(
                          text: Translation.get("done"),
                          press: () async {
                            var formdata = formcheckout.currentState!;
                            if (formdata.validate() &&
                                MyApi.SID !=
                                    'd3hhZmdQdkRrYnlKOktJdmdSWFVQamZZSnRlWDVqZm5wMXc9PQ==') {
                              int i =
                                  Provider.of<MyAddress>(context, listen: false)
                                      .myaddresses
                                      .indexWhere((element) =>
                                          element!.id.toString() ==
                                          MyApi.AddressId.toString());

                              var branches = Provider.of<GetDependants>(context,
                                      listen: false)
                                  .new_branches;
                              int b = branches.indexWhere((element) =>
                                  element['id'] ==
                                  Provider.of<MyAddress>(context, listen: false)
                                      .myaddresses[i]
                                      .branche_id);
                              if (b == -1) {
                                b = branches.indexWhere((element) =>
                                    element['area_id'] ==
                                    Provider.of<MyAddress>(context,
                                            listen: false)
                                        .myaddresses[i]
                                        .area_id);
                              }
                              int s = Provider.of<Getcategories>(context,
                                      listen: false)
                                  .shipping
                                  .indexWhere((element) =>
                                      element!['city_id'].toString() ==
                                      branches[b]['city_id']);

                              debugPrint(double.tryParse(
                                      Provider.of<Getcategories>(context,
                                                  listen: false)
                                              .shipping[s]['shipping_amount'] ??
                                          '0')
                                  .toString());
                              if (shipping_calc == false)
                                net += double.tryParse(
                                    Provider.of<Getcategories>(context,
                                                listen: false)
                                            .shipping[s]['shipping_amount'] ??
                                        '0')!;
                              debugPrint(endtotal.toString());
                              shipping_calc = true;

                              Loading().showloading(context);
                              if (selected_payment_code == 'paymob') {
                                await Provider.of<CheckoutC>(context,
                                        listen: false)
                                    .checkout(
                                        endtotal,
                                        val,
                                        selected_payment,
                                        coupon,
                                        mydate,
                                        format,
                                        context,
                                        '0',
                                        selected_payment_code);
                              } else {
                                await Provider.of<CheckoutC>(context,
                                        listen: false)
                                    .checkout(
                                        endtotal,
                                        val,
                                        selected_payment,
                                        coupon,
                                        mydate,
                                        format,
                                        context,
                                        '1',
                                        selected_payment_code);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ));
          });
        });
  }

  @override
  void initState() {
    endtotal = Provider.of<Cart>(context, listen: false).myendtotal;
    taxes = Provider.of<GetDependants>(context, listen: false).taxes;
    Map alltaxes = {};
    double totaltaxes = 0;
    for (var i = 0; i < taxes.length; i++) {
      String mytax = taxes[i].tax_equation ?? '0';
      Parser p = Parser();
      String newtax = mytax.replaceAll('x', '$endtotal');
      exp = p.parse(newtax);
      alltaxes[i] = exp!.evaluate(EvaluationType.REAL, ContextModel());
      totaltaxes += alltaxes[i];
      net = endtotal + totaltaxes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    endtotal = Provider.of<Cart>(context, listen: true).myendtotal;
    taxes = Provider.of<GetDependants>(context, listen: false).taxes;
    Map alltaxes = {};
    double totaltaxes = 0;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${Translation.get('total')}: $endtotal ${Translation.get('le')}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            // ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: Provider.of<GetDependants>(context, listen: false)
            //         .taxes
            //         .length,
            //     itemBuilder: (context, i) {
            //       var taxes =
            //           Provider.of<GetDependants>(context, listen: false).taxes;
            //       String mytax = taxes[i].tax_equation ?? '0';
            //       String? tax_name = taxes[i].name;
            //       Parser p = Parser();
            //       String newtax = mytax.replaceAll('x', '$endtotal');
            //       exp = p.parse(newtax);
            //       alltaxes[i] =
            //           exp!.evaluate(EvaluationType.REAL, ContextModel());
            //       totaltaxes += alltaxes[i];
            //       net = endtotal + totaltaxes;

            //       return Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Divider(),
            //           Text(
            //             "$tax_name: ${alltaxes[i].toStringAsFixed(1)} ${Translation.get('le')}",
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 18),
            //           ),
            //         ],
            //       );
            //     }),
            // Divider(),
            // Consumer<Cart>(builder: (context, cart, child) {
            //   return Text(
            //     "${Translation.get('net')}: ${net == 0 ? endtotal : net.toStringAsFixed(1)} ${Translation.get('le')}",
            //     style: TextStyle(
            //         color: kPrimaryColor,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18),
            //   );
            // }),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: getProportionateScreenWidth(180),
              child: Consumer<Cart>(builder: (context, cart, child) {
                return DefaultButton(
                  text: Translation.get('checkout'),
                  press: () async {
                    if (Provider.of<Getcategoryitems>(context, listen: false)
                            .user_id !=
                        null) {
                      if (endtotal != 0.0) {
                        selected_payment =
                            Provider.of<GetDependants>(context, listen: false)
                                .payments[0]
                                .id
                                .toString();
                        await checkout(context);
                      }
                    } else {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.INFO_REVERSED,
                              title: Translation.get('not-sign'),
                              btnOkColor: Colors.blue,
                              btnOkText: Translation.get('ok'),
                              btnOkOnPress: () {
                                Navigator.pushNamed(
                                    context, SignInScreen.routeName);
                              },
                              btnCancelText: Translation.get('cancel'),
                              btnCancelColor: Colors.red,
                              btnCancelOnPress: () {})
                          .show();
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
