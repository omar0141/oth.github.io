// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../controller/cart_wishlist.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription(
      {Key? key,
      this.item_name,
      this.item_price,
      this.bref,
      this.desc,
      this.item,
      this.item_whl_price})
      : super(key: key);

  final item_name;
  final item_price;
  final item_whl_price;
  final bref;
  final desc;
  final item;

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            '$item_name',
            style: const TextStyle(
                color: kPrimaryColor,
                fontFamily: 'Circular',
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Text(
                '${item.unit ?? ''}',
                style: const TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.white,
              child: Container()            ),
          ),
        ]),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 4,
          height: 4,
          color: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    '${item.price}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Circular',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' ${Translation.get('le')}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Circular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                add_to_cart(context, cart),
                added_to_cart(context, cart),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       padding: MaterialStateProperty.all<EdgeInsets>(
            //           EdgeInsets.symmetric(
            //               horizontal:
            //                   MediaQuery.of(context).size.width * 0.03)),
            //       backgroundColor: MaterialStateProperty.all(kPrimaryColor),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //       ),
            //     ),
            //     onPressed: (() {
            //       if (item.stock != 0 && item.stock != null) {
            //         cart.add(item, context);
            //       }
            //     }),
            //     child: Text(
            //       '+ Add Item',
            //       style: const TextStyle(
            //           color: Colors.white,
            //           fontFamily: 'Circular',
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // )
          ],
        ),
        // Padding(
        //   padding: EdgeInsets.only(
        //     left: getProportionateScreenWidth(20),
        //     right: getProportionateScreenWidth(20),
        //   ),
        //   child: Text(
        //     '$bref',
        //     maxLines: 3,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 10),
        //   child: Center(
        //     child: InkWell(
        //       onTap: () {
        //         showModalBottomSheet(
        //           context: context,
        //           builder: (context) {
        //             return Padding(
        //               padding: EdgeInsets.all(20),
        //               child: Text(
        //                 '$desc',
        //               ),
        //             );
        //           },
        //         );
        //       },
        //       child: Text(
        //         Translation.get('more-details'),
        //         style: TextStyle(
        //           color: kPrimaryColor,
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget add_to_cart(BuildContext context, Cart cart) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      height: item.qty == 0 ? 40 : 0,
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03)),
              backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: (() {
              if (item.stock != 0 && item.stock != null) {
                cart.add(item, context);
              }
            }),
            child: Text(
              '+ ${Translation.get('add-item')}',
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Circular',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget added_to_cart(BuildContext context, Cart cart) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      height: item.qty == 0 ? 0 : 40,
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: Size(35, 35),
              primary: kPrimaryColor,
              minimumSize: Size(35, 35),
              padding: EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: (() {
              cart.remove_qty(item, context);
            }),
            child: const Text(
              '-',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            padding: EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              '${item.qty.toInt()}',
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: Size(35, 35),
              primary: kPrimaryColor,
              minimumSize: Size(35, 35),
              padding: EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: (() {
              if (item.stock != 0 && item.stock != null) {
                cart.add(item, context);
              }
            }),
            child: const Text(
              '+',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
