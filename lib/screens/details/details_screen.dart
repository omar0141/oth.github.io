// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, await_only_futures

import 'package:flutter/material.dart';
import 'package:shakosh/controller/items.dart';
import 'package:shakosh/controller/products_details.dart';
import 'package:shakosh/controller/variants.dart';
import 'package:provider/provider.dart';
import '../home/home_screen.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  const DetailsScreen(
      {Key? key, this.itm_no, this.itm_name, this.price, this.item})
      : super(key: key);

  final itm_no;
  final itm_name;
  final price;
  final item;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List images = [];
  String? brief = '';
  String? description = '';

  getData() async {
    await Provider.of<ProductDetailsC>(context, listen: false)
        .getData(widget.itm_no, context);
    images = Provider.of<ProductDetailsC>(context, listen: false).images;
    images.add(widget.item.image);
    brief = Provider.of<ProductDetailsC>(context, listen: false).brief;
    description =
        Provider.of<ProductDetailsC>(context, listen: false).description;
    await Provider.of<Getcategoryitems>(context, listen: false)
        .getsimiliars(context, widget.itm_no);
    await Provider.of<GetVariants>(context, listen: false)
        .getVars(widget.itm_no, context);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
          return false;
        },
        child: Scaffold(
          body: Body(
            item_no: widget.itm_no,
            myimages: images,
            name: widget.itm_name,
            price: widget.price,
            description: description,
            brief: brief,
            item: widget.item,
          ),
        ),
      ),
    );
  }
}
