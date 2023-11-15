import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/ScaffoldMobile/Components/MyBottomNavigationBar.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Screens/Products/ProductSearchMobileScreen.dart';

// ignore: must_be_immutable
class ScaffoldMobile extends StatefulWidget {
  ScaffoldMobile(
      {super.key,
      required this.child,
      this.appBar,
      this.screenName,
      this.index,
      this.searchOpened = false,
      this.bottomNavigationBar,
      this.search,
      this.categoryId,
      this.brandId});

  String? search;
  String? categoryId;
  String? brandId;
  final Widget child;
  final AppBar? appBar;
  final String? screenName;
  int? index;
  bool searchOpened;
  Widget? bottomNavigationBar;

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
    return SafeArea(
      child: Scaffold(
        appBar: widget.appBar ?? myAppBar(context, widget.screenName ?? ""),
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
          visible: false,
          // visible: !isVisible1,
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
        bottomNavigationBar: widget.bottomNavigationBar == null
            ? Visibility(
                visible: isVisible2,
                child: MyBottomNavigationBar(
                  index: widget.index ?? 0,
                ))
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.bottomNavigationBar!,
                ],
              ),
      ),
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
        if (!widget.searchOpened)
          Padding(
            padding:
                const EdgeInsetsDirectional.only(end: 10, top: 10, bottom: 10),
            child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                String? brandId = widget.brandId;
                String? search = widget.search ?? "";
                String? categoryId = widget.categoryId;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProductSearchMobileScreen(
                    brandId: brandId,
                    categoryId: categoryId,
                    search: search,
                  );
                }));
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
