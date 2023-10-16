import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Address/address_bloc.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Components/LoadingDropDown.dart';
import 'package:shakosh/new/Components/default_button.dart';
import 'package:shakosh/new/Components/dialogs.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/AddressModel.dart';
import 'package:shakosh/new/Data/Models/ShippingModel.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/new/Screens/Login/LoginScreen.dart';

// ignore: must_be_immutable
class TotalCartWidget extends StatefulWidget {
  TotalCartWidget({super.key});

  @override
  State<TotalCartWidget> createState() => _TotalCartWidgetState();
}

class _TotalCartWidgetState extends State<TotalCartWidget> {
  late String addressId;
  double deliveyFees = 0;
  double total = 0;
  double totalDiscount = 0;
  double totalTax = 0;
  double net = 0;

  @override
  void initState() {
    total = BlocProvider.of<CartBloc>(context).total;
    totalDiscount = BlocProvider.of<CartBloc>(context).totalDiscount;
    totalTax = BlocProvider.of<CartBloc>(context).totalTax;
    net = BlocProvider.of<CartBloc>(context).net;
    List<AddressModel> addresses = BlocProvider.of<AddressBloc>(context).addresses;
    if (addresses.isNotEmpty) {
      addressId = addresses.first.id ?? "";
      calcShipping(addresses, addressId, context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  if (MyApi.UID != "")
                  BlocConsumer<AddressBloc, AddressState>(
                    listener: (context, state) {
                        if (state.adresses.isNotEmpty) {
                          addressId = state.adresses.first.id ?? "";
                          calcShipping(state.adresses, addressId, context);
                        }
                      
                    },
                    builder: (context, state) {
                      if (state is AddressesLoading) {
                        return loadingInput();
                      } else {
                        if (state.adresses.isNotEmpty) {
                          return addressesDropDown(
                              state.adresses, "delivery-address".tr, context,
                              onChange: (value) {
                            addressId = value.toString();
                            calcShipping(state.adresses, addressId, context);
                          });
                        } else {
                          return Container();
                        }
                      }
                    },
                  ),
                  if (MyApi.UID != "")
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "total".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        total.toStringAsFixed(2) + " " + "le".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "total-discount".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        totalDiscount.toStringAsFixed(2) + " " + "le".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "total-tax".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        totalTax.toStringAsFixed(2) + " " + "le".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  if (MyApi.UID != "")
                  Divider(),
                  if (MyApi.UID != "")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "delivery-fees".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        deliveyFees.toStringAsFixed(2) + " " + "le".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "net".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        net.toStringAsFixed(2) + " " + "le".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: (state is CheckoutCartLoading)
                          ? DefaultButton(
                              fontsize: 16,
                              submit: true,
                              press: () {},
                              text: "".tr,
                            )
                          : DefaultButton(
                              fontsize: 16,
                              press: () {
                                if (MyApi.UID != "") {
                                  String payment_method_id =
                                      BlocProvider.of<DependanciesBloc>(context)
                                          .dependantsData
                                          .payments!
                                          .first
                                          .id!;
                                  BlocProvider.of<CartBloc>(context).add(
                                      CheckoutCartEvent(
                                          addressId: addressId,
                                          paymentId: payment_method_id));
                                } else {
                                  MyDialogs().showdialog(
                                      navigatorKey.currentContext!,
                                      DialogType.infoReverse,
                                      mySize(screenWidth * 0.95,
                                          screenWidth * 0.95, 400, 400, 400),
                                      "you-need-to-sign-in-first".tr,
                                      "sorry".tr, () {
                                    Navigator.of(navigatorKey.currentContext!)
                                        .pushNamed(LoginScreen.routeName);
                                  }, null, buttonOkText: "sign-in".tr);
                                }
                              },
                              text: "checkout".tr,
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  calcShipping(List<AddressModel> adresses, String value, BuildContext context) {
    int i = adresses.indexWhere((element) => element.id.toString() == value.toString());
    if (i > -1) {
      List<ShippingModel> shippings = BlocProvider.of<DependanciesBloc>(context).shippings;
      int d = shippings.indexWhere((element) {
        return element.cityId.toString().toLowerCase() == adresses[i].cityId.toString().toLowerCase();
        });
      if (d > -1) {
        deliveyFees = double.parse((shippings[d].shippingAmount ?? 0).toString());
      }
      net = BlocProvider.of<CartBloc>(context).net;
      net += deliveyFees;
      setState(() {});
    }
  }

  DropdownButtonFormField addressesDropDown(
      List<AddressModel> items, text, context,
      {required Function(String value) onChange}) {
    String initValue = items.first.id ?? "";

    return DropdownButtonFormField(
        padding: EdgeInsets.all(0),
        isExpanded: true,
        value: initValue,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
        ),
        items: [
          if (items.isEmpty)
            DropdownMenuItem(
                value: "",
                child: Text(
                  text,
                  style: TextStyle(
                      color: colors(context).kprimaryColor!.withOpacity(0.7)),
                )),
          for (var item in items)
            DropdownMenuItem(
                value: item.id,
                child: Text(
                  item.name ?? "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                )),
        ],
        onChanged: (value) => onChange(value.toString()));
  }
}
