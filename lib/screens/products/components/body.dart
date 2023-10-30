import 'package:shakosh/components/product_card.dart';
import 'package:shakosh/constants.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../new/Data/Remote/MyApi.dart';
import '../../../controller/categories.dart';
import '../../../controller/items.dart';
import '../../../helper/translation.dart';

class Body extends StatefulWidget {
  final id;
  const Body({this.id, Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isSwitched = false;

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
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Stock Only',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      if (value == true) {
                        Provider.of<Getcategoryitems>(context, listen: false)
                            .myswitched = 1;
                      } else {
                        Provider.of<Getcategoryitems>(context, listen: false)
                            .myswitched = 0;
                      }
                      setState(() {
                        isSwitched = value;
                      });
                      Provider.of<Getcategoryitems>(context, listen: false)
                          .getitemscat(
                              Provider.of<Getcategoryitems>(context,
                                      listen: false)
                                  .catgeory_id,
                              context,
                              1,
                              null,
                              Provider.of<Getcategoryitems>(context,
                                      listen: false)
                                  .myswitched,
                              null);
                      Navigator.pop(context);
                    },
                    activeTrackColor: kPrimaryLightColor,
                    activeColor: kPrimaryColor,
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    Provider.of<Getcategoryitems>(context, listen: false).getitemscat(
        widget.id,
        context,
        1,
        null,
        Provider.of<Getcategoryitems>(context, listen: false).myswitched,
        null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Getcategoryitems>(context, listen: true).loading == true) {
      return const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Provider.of<Getcategories>(context, listen: false).deals == []
                  ? dealsSection(context)
                  : Container(),
              Provider.of<Getcategoryitems>(context, listen: true)
                              .pageintaion ==
                          true &&
                      Provider.of<Getcategoryitems>(context, listen: false)
                              .loading ==
                          false
                  ? Pagination(
                      Provider.of<Getcategoryitems>(context, listen: false)
                          .pages,
                      Provider.of<Getcategoryitems>(context, listen: false)
                          .cPage)
                  : Container(),
              products(),
              Provider.of<Getcategoryitems>(context, listen: true)
                              .pageintaion ==
                          true &&
                      Provider.of<Getcategoryitems>(context, listen: false)
                              .loading ==
                          false
                  ? Pagination(
                      Provider.of<Getcategoryitems>(context, listen: false)
                          .pages,
                      Provider.of<Getcategoryitems>(context, listen: false)
                          .cPage)
                  : Container(),
            ],
          ),
        ),
      );
    }
  }

  Container Pagination(maxPages, currPage) {
    int d = currPage - 2;
    int s = (d < 1 ? 1 : d);
    int e = (s + 4);
    if (e > maxPages) e = maxPages;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
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
                    icon:
                        const Icon(Icons.arrow_back_ios, color: Colors.black45),
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
                      child: Container())),
            );
          },
        );
      }).toList(),
    );
  }

  Consumer<Getcategoryitems> products() {
    return Consumer<Getcategoryitems>(builder: (context, value, _) {
      return Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          for (int d = 0; d < value.items.length; d++)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: ProductCard(value.items[d], false, kPrimaryColor),
            )
        ],
      );
    });
  }
}
