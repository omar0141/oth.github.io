import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/controller/cart_wishlist.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:share_plus/share_plus.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({this.images, this.item});
  final List? images;
  final item;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  Future<void> _createDynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          "https://retail.ghstylefurniture.com/?id=${widget.item.item_no}&name=${widget.item.name}&price=${widget.item.price}&item=${jsonEncode(widget.item)}"),
      uriPrefix: "https://ghstylefurniture.page.link",
      androidParameters:
          const AndroidParameters(packageName: "com.exabytellc.shakosh"),
      iosParameters: const IOSParameters(bundleId: "com.exabytellc.shakosh"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    Uri newlink = Uri.parse(dynamicLink.queryParameters['link'].toString());
    debugPrint(dynamicLink.toString());
    Share.share(newlink.toString());
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: true);
    return Column(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(),
              ),
            ),

            // Positioned(
            //   left: 0,
            //   child: CircleAvatar(
            //     maxRadius: 25,
            //     backgroundColor: Colors.white.withOpacity(0.5),
            //     child: IconButton(
            //       onPressed: () {
            //         _createDynamicLink();
            //       },
            //       icon: const Icon(
            //         Icons.share,
            //         color: kPrimaryColor,
            //         size: 25,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        // Center(
        //   child: Container(
        //       margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        //       height: 50,
        //       child: ListView(
        //         shrinkWrap: true,
        //         scrollDirection: Axis.horizontal,
        //         children: [
        //           ...List.generate(widget.images!.length,
        //               (index) => buildSmallProductPreview(index)),
        //         ],
        //       )),
        // )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
          duration: defaultDuration,
          margin: const EdgeInsets.only(right: 15),
          height: getProportionateScreenWidth(50),
          width: getProportionateScreenWidth(50),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color:
                    kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
          ),
          child: Container()),
    );
  }
}
