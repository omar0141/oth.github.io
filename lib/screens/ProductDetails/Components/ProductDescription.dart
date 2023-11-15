import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:shakosh/Config/Utils/HtmlStyle.dart';
import 'package:shakosh/Config/Utils/SizeConfig.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Data/Models/ProductDetailsModel.dart';

// ignore: must_be_immutable
class ProductDetailsDescription extends StatefulWidget {
  ProductDetailsDescription({super.key, required this.productDetails});

  ProductDetailsModel productDetails;

  @override
  State<ProductDetailsDescription> createState() =>
      _ProductDetailsDescriptionState();
}

class _ProductDetailsDescriptionState extends State<ProductDetailsDescription> {
  String copiedText = "";

  String selectedText = "description".tr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tabWidget("description".tr),
            if (widget.productDetails.tech_info != null &&
                widget.productDetails.tech_info != "")
              tabWidget("tech-info".tr),
            if (widget.productDetails.content_info != null &&
                widget.productDetails.content_info != "")
              tabWidget("content-info".tr),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedText == "description".tr)
                Expanded(
                  child: HtmlWidget(
                    "language_iso".tr == "ar"
                        ? widget.productDetails.descriptionAlt ?? ""
                        : widget.productDetails.description ?? "",
                    textStyle: TextStyle(
                      fontSize: mySize(14, 14, 16, 18, 18),
                      height: "language_iso".tr == "ar" ? 1.5 : 1.2,
                    ),
                    customStylesBuilder: (element) {
                      return htmlStyle(element, context);
                    },
                  ),
                ),
              if (selectedText == "tech-info".tr)
                Expanded(
                  child: HtmlWidget(
                    widget.productDetails.tech_info ?? "",
                    textStyle: TextStyle(
                      fontSize: mySize(14, 14, 16, 18, 18),
                      height: "language_iso".tr == "ar" ? 1.5 : 1.2,
                    ),
                    customStylesBuilder: (element) {
                      return htmlStyle(element, context);
                    },
                  ),
                ),
              if (selectedText == "content-info".tr)
                Expanded(
                  child: HtmlWidget(
                    widget.productDetails.content_info ?? "",
                    textStyle: TextStyle(
                      fontSize: mySize(14, 14, 16, 18, 18),
                      height: "language_iso".tr == "ar" ? 1.5 : 1.2,
                    ),
                    customStylesBuilder: (element) {
                      return htmlStyle(element, context);
                    },
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget tabWidget(text) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 10),
      decoration: BoxDecoration(
          color: text == selectedText ? colors(context).kprimaryColor : null,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: colors(context).kprimaryColor!)),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          selectedText = text;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: TextStyle(
                color: text == selectedText
                    ? colors(context).whiteColor
                    : colors(context).normalTextColor),
          ),
        ),
      ),
    );
  }
}
