// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, must_be_immutable

import 'package:shakosh/screens/categories/category_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/components/product_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/helper/translation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../constants.dart';
import '../../../controller/MyApi.dart';
import '../../../controller/categories.dart';
import '../../../controller/items.dart';
import '../../details/details_screen.dart';

class Categories extends StatefulWidget {
  String? page;
  int? parent_id;
  Categories({Key? key, this.page, this.parent_id}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  showsort() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              InkWell(
                onTap: () async {
                  Provider.of<Getcategoryitems>(context, listen: false).sort =
                      'price-desc';
                  Provider.of<Getcategoryitems>(context, listen: false)
                      .getitemscat(
                          Provider.of<Getcategoryitems>(context, listen: false)
                              .catgeory_id,
                          context,
                          1,
                          null,
                          Provider.of<Getcategoryitems>(context, listen: false)
                              .myswitched,
                          null);
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_upward,
                    color: kPrimaryColor,
                  ),
                  title: Text(Translation.get('highest-price')),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () async {
                  Provider.of<Getcategoryitems>(context, listen: false).sort =
                      'price-asc';
                  Provider.of<Getcategoryitems>(context, listen: false)
                      .getitemscat(
                          Provider.of<Getcategoryitems>(context, listen: false)
                              .catgeory_id,
                          context,
                          1,
                          null,
                          Provider.of<Getcategoryitems>(context, listen: false)
                              .myswitched,
                          null);
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_downward,
                    color: kPrimaryColor,
                  ),
                  title: Text(Translation.get('lowest-price')),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () async {
                  Provider.of<Getcategoryitems>(context, listen: false).sort =
                      'name-desc';
                  Provider.of<Getcategoryitems>(context, listen: false)
                      .getitemscat(
                          Provider.of<Getcategoryitems>(context, listen: false)
                              .catgeory_id,
                          context,
                          1,
                          null,
                          Provider.of<Getcategoryitems>(context, listen: false)
                              .myswitched,
                          null);
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_upward,
                    color: kPrimaryColor,
                  ),
                  title: Text(Translation.get('desc-name')),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () async {
                  Provider.of<Getcategoryitems>(context, listen: false).sort =
                      'name-asc';
                  Provider.of<Getcategoryitems>(context, listen: false)
                      .getitemscat(
                          Provider.of<Getcategoryitems>(context, listen: false)
                              .catgeory_id,
                          context,
                          1,
                          null,
                          Provider.of<Getcategoryitems>(context, listen: false)
                              .myswitched,
                          null);
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_downward,
                    color: kPrimaryColor,
                  ),
                  title: Text(Translation.get('asc-name')),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Provider.of<Getcategories>(context, listen: false).deals == []
            ? dealsSection(context)
            : Container(),
        dailyPicks(),
        categories(),
      ],
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
                        imageUrl: MyApi.media + data['thumbnail'],
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

  Widget dailyPicks() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Translation.get('daily-picks'),
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
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
        SizedBox(
          height: 150,
          child: Consumer<Getcategoryitems>(
            builder: (context, value, _) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: value.getItems.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailsScreen(
                            itm_no: value.getItems[i].item_no,
                            itm_name: value.getItems[i].name,
                            price: value.getItems[i].price,
                            item: value.getItems[i],
                          );
                        }));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                                child: CachedNetworkImage(
                                  imageUrl: value.getItems[i].image ?? '',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                          color: kPrimaryColor),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/logo.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              value.getItems[i].name.toString(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget categories() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Translation.get('category'),
              style: TextStyle(
                fontFamily: 'Circular',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 104, 169, 49),
              ),
            ),
            Container(
              width: 180,
              padding: EdgeInsets.only(top: 15, left: 5),
              child: Divider(
                thickness: 1.5,
                height: 2,
                color: Color.fromARGB(255, 104, 169, 49),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Consumer<Getcategories>(builder: (context, value, _) {
            // if (value.loading == true) {
            //   return const Center(
            //     child: CircularProgressIndicator(
            //       color: kPrimaryColor,
            //     ),
            //   );
            // } else {
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 3,
                    crossAxisCount: kIsWeb ? 5 : 4,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.30)),
                itemCount: value.categories.length,
                itemBuilder: (context, i) {
                  if (value.categories[i].parent_id == null) {
                    return Padding(
                      padding: const EdgeInsets.all(3),
                      child: InkWell(
                          onTap: () async {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return CategoryScreen(
                                id: value.categories[i].id,
                                name: value.categories[i].name,
                                image: value.categories[i].image,
                              );
                            }));
                            // Provider.of<Getcategories>(context, listen: false)
                            //     .select_cat(value.categories[i]);
                            // Provider.of<Getcategoryitems>(context,
                            //         listen: false)
                            //     .getitemscat(
                            //         widget.parent_id,
                            //         context,
                            //         1,
                            //         null,
                            //         Provider.of<Getcategoryitems>(context,
                            //                 listen: false)
                            //             .myswitched,
                            //         null);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                color: kPrimaryColor
                                // image: DecorationImage(
                                //   image:
                                //       AssetImage('assets/images/background.png'),
                                //   fit: BoxFit.cover,
                                // ),
                                ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: value.categories[i].image ?? '',
                                  fit: BoxFit.contain,
                                  width: 80,
                                  height: 80,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                          color: kPrimaryColor),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/logo.png',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  value.categories[i].name.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )),
                    );
                  } else {
                    return Container();
                  }
                  // return ProductCard(value.getItems[i], false,
                  //     Color.fromARGB(255, 255, 168, 28));
                });
            // }
          }),
        ),
      ],
    );
  }

  Row Pagination(maxPages, currPage) {
    int d = currPage - 2;
    int s = (d < 1 ? 1 : d);
    int e = (s + 4);
    if (e > maxPages) e = maxPages;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              showsort();
            },
            child: const Icon(
              Icons.filter_alt_outlined,
              color: kPrimaryColor,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showsort();
          },
          child: Text(
            Translation.get('sort'),
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        currPage > 1
            ? Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kPrimaryColor, width: 1)),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black45),
                  iconSize: 15,
                  onPressed: () async {
                    if (currPage > 1) {
                      Provider.of<Getcategoryitems>(context, listen: false)
                          .getitemscat(
                              Provider.of<Getcategoryitems>(context,
                                      listen: false)
                                  .catgeory_id,
                              context,
                              currPage - 1,
                              null,
                              Provider.of<Getcategoryitems>(context,
                                      listen: false)
                                  .myswitched,
                              null);
                    }
                  },
                ),
              )
            : Container(),
        Container(
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kPrimaryColor, width: 1)),
          child: Row(
            children: List.generate((maxPages < 5 ? maxPages : 5), (i) {
              int c = s + i;
              return InkWell(
                child: Container(
                    decoration: BoxDecoration(
                        border: Translation.get('language_iso') == 'en'
                            ? Border(
                                left: c > s
                                    ? const BorderSide(
                                        color: kPrimaryColor, width: 1)
                                    : BorderSide.none)
                            : Border(
                                right: c > s
                                    ? const BorderSide(
                                        color: kPrimaryColor, width: 1)
                                    : BorderSide.none)),
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      (c).toString(),
                      style: TextStyle(
                        color: (currPage != c ? Colors.black : kPrimaryColor),
                      ),
                    )),
                onTap: () async {
                  if (currPage != c) {
                    Provider.of<Getcategoryitems>(context, listen: false)
                        .getitemscat(
                            Provider.of<Getcategoryitems>(context,
                                    listen: false)
                                .catgeory_id,
                            context,
                            c,
                            null,
                            Provider.of<Getcategoryitems>(context,
                                    listen: false)
                                .myswitched,
                            null);
                  }
                },
              );
            }),
          ),
        ),
        currPage < maxPages
            ? Container(
                margin: Translation.get('language_iso') == 'en'
                    ? EdgeInsets.only(right: 10)
                    : EdgeInsets.only(left: 10),
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kPrimaryColor, width: 1)),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Colors.black45),
                  iconSize: 15,
                  onPressed: () async {
                    if (currPage < maxPages) {
                      Provider.of<Getcategoryitems>(context, listen: false)
                          .getitemscat(
                              Provider.of<Getcategoryitems>(context,
                                      listen: false)
                                  .catgeory_id,
                              context,
                              currPage + 1,
                              null,
                              Provider.of<Getcategoryitems>(context,
                                      listen: false)
                                  .myswitched,
                              null);
                    }
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}



// Consumer<Getcategories>(builder: (context, value, _) {
//             return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: value.categories.length,
//                 itemBuilder: (context, i) {
//                   if (value.categories[i].parent_id == null) {
//                     return Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: InkWell(
//                           onTap: () async {
//                             Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (context) {
//                               return CategoryScreen(
//                                 id: value.categories[i].id,
//                                 name: value.categories[i].name,
//                                 image: value.categories[i].image,
//                               );
//                             }));
//                             // Provider.of<Getcategories>(context, listen: false)
//                             //     .select_cat(value.categories[i]);
//                             // Provider.of<Getcategoryitems>(context,
//                             //         listen: false)
//                             //     .getitemscat(
//                             //         widget.parent_id,
//                             //         context,
//                             //         1,
//                             //         null,
//                             //         Provider.of<Getcategoryitems>(context,
//                             //                 listen: false)
//                             //             .myswitched,
//                             //         null);
//                           },
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               CircleAvatar(
//                                 backgroundColor: kPrimaryColor,
//                                 radius: 35,
//                                 child: CachedNetworkImage(
//                                   imageUrl: value.categories[i].image ?? '',
//                                   fit: BoxFit.contain,
//                                   width: 50,
//                                   height: 50,
//                                   placeholder: (context, url) =>
//                                       CircularProgressIndicator(
//                                           color: kPrimaryColor),
//                                   errorWidget: (context, url, error) =>
//                                       Image.asset(
//                                     'assets/images/logo.png',
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 value.categories[i].name.toString(),
//                                 textAlign: TextAlign.center,
//                               )
//                             ],
//                           )),
//                     );
//                   } else {
//                     return Container();
//                   }
//                 });
//           } 