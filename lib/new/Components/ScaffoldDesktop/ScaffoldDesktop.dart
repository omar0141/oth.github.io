import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/Components/Header1.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/Components/Header2.dart';
import 'package:shakosh/new/Screens/Cart/CartScreen.dart';

// ignore: must_be_immutable
class ScaffoldDesktop extends StatefulWidget {
  ScaffoldDesktop(
      {super.key,
      required this.child,
      this.brandId,
      this.search,
      this.categoryId,
      this.products = false});
  final Widget child;
  String? brandId;
  String? categoryId;
  String? search;
  bool products;

  @override
  State<ScaffoldDesktop> createState() => _ScaffoldDesktopState();
}

class _ScaffoldDesktopState extends State<ScaffoldDesktop> {
  ScrollController scrollController = ScrollController();
  bool isVisibleHeader2 = true;
  bool isVisibleHeader1 = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!scrollController.position.atEdge) {
          isVisibleHeader1 = false;
        }
        isVisibleHeader2 = false;
        setState(() {});
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (scrollController.position.atEdge) {
          isVisibleHeader1 = true;
        }
        isVisibleHeader2 = true;
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
      key: scaffoldKey,
      endDrawer: Drawer(width: 400, child: CartScreen()),
      floatingActionButton: Visibility(
        visible: !isVisibleHeader2,
        child: GestureDetector(
          onTap: () {
            scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
            isVisibleHeader1 = true;
            isVisibleHeader2 = true;
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
      body: Column(
        children: [
          Visibility(
              visible: isVisibleHeader1,
              child: Header1(
                categoryId: widget.categoryId,
                search: widget.search,
                brandId: widget.brandId,
                products: widget.products,
              )),
          Header2(
            scaffoldKey: scaffoldKey,
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: (screenWidth > 1500) ? 1500 : null,
                child: ListView(
                    controller: scrollController,
                    children: [widget.child, footer(context)]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget footer(context) {
    return Container(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "© 2023 Bayt Aleadad",
                style: TextStyle(color: colors(context).grey1),
              ),
              SelectableText("Sales@originaltoolshome.com"),
              SelectableText(
                "جسر السويس القاهرة - مصر",
                style: TextStyle(height: 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
