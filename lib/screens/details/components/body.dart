// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors

import 'package:shakosh/screens/home/home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shakosh/constants.dart';
import 'package:shakosh/controller/variants.dart';
import 'package:shakosh/helper/translation.dart';
import 'package:shakosh/screens/details/details_screen.dart';
import 'package:shakosh/size_config.dart';
import '../../../components/product_card.dart';
import '../../../controller/items.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/controller/cart_wishlist.dart';

class Body extends StatefulWidget {
  final name;
  final price;
  final item_no;
  final whl_price;
  final brief;
  final description;
  final List? myimages;
  final item;
  const Body(
      {Key? key,
      required this.name,
      this.price,
      this.item_no,
      this.brief,
      this.description,
      this.whl_price,
      this.myimages,
      this.item})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: true);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 5,
                child: Row(
                  children: [
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/detail-header.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/detail-header.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/detail-header.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/detail-header.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/detail-header.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/detail-header.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/detail-header.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 224, 245, 255),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ProductImages(
                            images: widget.myimages, item: widget.item),
                      ),
                      ProductDescription(
                          item_price: widget.price,
                          item_name: widget.name,
                          bref: widget.brief,
                          desc: widget.description,
                          item_whl_price: widget.whl_price,
                          item: widget.item),
                    ],
                  ),
                ),
              ),
              Positioned(
                  child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: kPrimaryColor,
                ),
                onPressed: (() {
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                }),
              )),
            ],
          ),
          Container(
            margin: Translation.get('language_iso') == 'en'
                ? EdgeInsets.only(left: 15)
                : EdgeInsets.only(right: 15),
            width: double.infinity,
            child: Text(
              Translation.get('you-might'),
              // textAlign: Translation.get('language_iso') == 'en'
              //     ? TextAlign.left
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'Circular',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: similars(),
          ),
          // TopRoundedContainer(
          //   color: Colors.white,
          //   child: Column(
          //     children: [
          //       // Column(
          //       //   children: [
          //       //     add_to_cart(context, cart),
          //       //    added_to_cart(context, cart),
          //       //     Divider(
          //       //     thickness: 2,
          //       //     ),
          //       //     variants(),
          //       //   ],
          //       // ),
          //       // Divider(
          //       //   thickness: 2,
          //       // ),

          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Container similars() {
    return Container(
      margin: const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 10),
      height: getProportionateScreenHeight(300),
      child: Consumer<Getcategoryitems>(builder: (context, value, _) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: value.getsimiliar.length,
            itemBuilder: (context, i) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  width: getProportionateScreenWidth(180),
                  child:
                      ProductCard(value.getsimiliar[i], false, kPrimaryColor));
            });
      }),
    );
  }

  Container variants() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer<GetVariants>(
        builder: (context, value, _) {
          return Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: value.variants.entries.map(
                  (entry) {
                    VariantBasis options = entry.value;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          options.name!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.75),
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: options.values.entries.map(
                              (entry) {
                                VariantValues values = entry.value;

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      child: InkWell(
                                        onTap: () {
                                          if (values.selected == false) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DetailsScreen(
                                                    itm_no:
                                                        values.product.item_no,
                                                    itm_name:
                                                        values.product.name,
                                                    price: values.product.price,
                                                    item: values.product,
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              (options.thumbnail ? 0 : 10)),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: (values.selected
                                                  ? kPrimaryColor
                                                  : Colors.transparent),
                                            ),
                                          ),
                                          child: (options.thumbnail &&
                                                  values.product.image != ''
                                              ? SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: CachedNetworkImage(
                                                    imageUrl: values
                                                        .product.image
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(
                                                      color: kPrimaryColor,
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            'assets/images/logo.png'),
                                                  ),
                                                )
                                              : Text(
                                                  values.name!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget add_to_cart(BuildContext context, Cart cart) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      height: widget.item.qty == 0 ? 40 : 0,
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.item.qty == null || widget.item.qty == 0
              ? ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.09)),
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: (() {
                    if (widget.item.stock != 0 && widget.item.stock != null) {
                      cart.add(widget.item, context);
                    }
                  }),
                  child: Text(
                    Translation.get('add-to-cart'),
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(35, 35),
                    minimumSize: Size(35, 35),
                    padding: EdgeInsets.only(bottom: 10),
                    primary: kPrimaryColor.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: (() {
                    cart.remove_qty(widget.item, context);
                  }),
                  child: const Text(
                    '-',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
          if (widget.item.qty != null && widget.item.qty != 0)
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              padding: EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                '${widget.item.qty.toInt()}',
                textAlign: TextAlign.center,
              ),
            ),
          if (widget.item.qty != null && widget.item.qty != 0)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: Size(35, 35),
                minimumSize: Size(35, 35),
                padding: EdgeInsets.only(bottom: 10),
                primary: kPrimaryColor.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: (() {
                if (widget.item.stock != 0 && widget.item.stock != null) {
                  cart.add(widget.item, context);
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

  Widget added_to_cart(BuildContext context, Cart cart) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      height: widget.item.qty == 0 ? 0 : 40,
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: Size(35, 35),
              minimumSize: Size(35, 35),
              padding: EdgeInsets.only(bottom: 10),
              primary: kPrimaryColor.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: (() {
              cart.remove_qty(widget.item, context);
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
                color: Colors.brown.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              '${widget.item.qty.toInt()}',
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: Size(35, 35),
              minimumSize: Size(35, 35),
              padding: EdgeInsets.only(bottom: 10),
              primary: kPrimaryColor.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: (() {
              if (widget.item.stock != 0 && widget.item.stock != null) {
                cart.add(widget.item, context);
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
