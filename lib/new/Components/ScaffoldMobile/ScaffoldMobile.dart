import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/Components/MyBottomNavigationBar.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Products/ProductSearchMobileScreen.dart';

// ignore: must_be_immutable
class ScaffoldMobile extends StatefulWidget {
  ScaffoldMobile({
    super.key,
    required this.child,
    this.appBar,
    this.screenName,
    this.index,
    this.searchOpened = false,
  });
  final Widget child;
  final AppBar? appBar;
  final String? screenName;
  int? index;
  bool searchOpened;

  @override
  State<ScaffoldMobile> createState() => _ScaffoldMobileState();
}

class _ScaffoldMobileState extends State<ScaffoldMobile> {
  ScrollController scrollController = ScrollController();
  bool isVisible1 = true;
  bool isVisible2 = true;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!scrollController.position.atEdge) {
          isVisible1 = false;
        }
        isVisible2 = false;
        setState(() {});
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (scrollController.position.atEdge) {
          isVisible1 = true;
        }
        isVisible2 = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isVisible2
          ? (widget.appBar ?? myAppBar(context, widget.screenName ?? ""))
          : null,
      body: Container(
        color: colors(context).whiteColor,
        child: ListView(
          controller: scrollController,
          children: [
            widget.child,
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isVisible1,
        child: GestureDetector(
          onTap: () {
            scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
            isVisible1 = true;
            isVisible2 = true;

            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: colors(context).kprimaryColor,
                borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.arrow_upward,
              color: colors(context).whiteColor,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
          visible: isVisible2,
          child: MyBottomNavigationBar(
            index: widget.index ?? 0,
          )),
    );
  }

  AppBar myAppBar(BuildContext context, text) {
    return AppBar(
      backgroundColor: colors(context).whiteColor,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colors(context).kprimaryColor,
                  fontFamily: "font-family".tr),
            ),
          ),
        ],
      ),
      leading: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        child: InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 236, 236),
                borderRadius: BorderRadius.circular(5)),
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: colors(context).normalTextColor,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding:
              const EdgeInsetsDirectional.only(end: 10, top: 10, bottom: 10),
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              if (widget.searchOpened) {
                String route;
                String? brandId =
                    BlocProvider.of<ProductsBloc>(context).brandId;
                String? search =
                    BlocProvider.of<ProductsBloc>(context).search ?? "";
                String? categoryId =
                    BlocProvider.of<ProductsBloc>(context).categoryId;
                if (brandId != null) {
                  route = "brands/${brandId}/products/1/$search";
                } else if (categoryId != null) {
                  route = "categories/${categoryId}/products/1/$search";
                } else if (brandId != null && categoryId != null) {
                  route =
                      "categories/${categoryId}/brands/${brandId}/products/1/$search";
                } else {
                  route = "products/1/$search";
                }

                Navigator.of(context).pushReplacementNamed(route);
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProductSearchMobileScreen();
                }));
              }
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 236, 236),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.search,
                color: colors(context).normalTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
