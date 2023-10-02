import 'package:shakosh/components/product_card.dart';
import 'package:shakosh/constants.dart';
import 'package:shakosh/helper/translation.dart';
import 'package:shakosh/models/Item.dart';
import 'package:shakosh/screens/products/product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../controller/MyApi.dart';
import '../../../controller/categories.dart';
import '../../../controller/items.dart';
import '../../../models/Category.dart';

class Body extends StatefulWidget {
  final id;
  final image;
  const Body({this.id, this.image, Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    List<Category> categories =
        Provider.of<Getcategories>(context, listen: false).subcategories;
    return SingleChildScrollView(
      child: Column(
        children: [
          Provider.of<Getcategories>(context, listen: false).deals == []
              ? dealsSection(context)
              : Container(),
          for (int i = 0; i < categories.length; i++)
            if (categories[i].parent_id == widget.id)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            categories[i].name!,
                            style: TextStyle(
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color.fromARGB(255, 255, 168, 28),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 15, left: 5),
                              child: Divider(
                                thickness: 1.5,
                                height: 2,
                                color: Color.fromARGB(255, 255, 168, 28),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Consumer<Getcategoryitems>(builder: (context, value, _) {
                      return Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          for (int d = 0;
                              d < value.category_products.length;
                              d++)
                            if (value.category_products[d].grp_code ==
                                categories[i].id)
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: ProductCard(value.category_products[d],
                                    false, kPrimaryColor),
                              )
                        ],
                      );
                    }),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductScreen(
                            id: categories[i].id,
                            name: categories[i].name,
                            image: widget.image,
                          );
                        }));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              Translation.get('see-more'),
                              style:
                                  TextStyle(color: kPrimaryColor, height: 0.1),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Image.asset(
                            'assets/icons/down-arrow.png',
                            width: 40,
                            height: 30,
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
        ],
      ),
    );
  }

  Widget dealsSection(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 100.0,
        enableInfiniteScroll: false,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
      items:
          Provider.of<Getcategories>(context, listen: false).deals.map((data) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () async {
                await Provider.of<Getcategoryitems>(context, listen: false)
                    .getitemscat(null, context, null, null, 0, data['id']);
              },
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: MyApi.public + data['thumbnail'],
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/logo.png'),
                      ))),
            );
          },
        );
      }).toList(),
    );
  }
}
