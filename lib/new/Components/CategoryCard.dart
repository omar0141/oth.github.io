import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  CategoryCard(
      {super.key, required this.category, this.parentId, this.expand = false});

  final category;
  String? parentId;
  bool expand;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: parentId == category.id
              ? colors(context).grey2!.withOpacity(0.5)
              : null,
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
                height: mySize(65, 65, 100, 100, 100),
                width: mySize(65, 65, 100, 100, 100),
                imageUrl: MyApi.media + (category.thumbnail ?? ""),
                placeholder: (context, url) => Center(
                      child: SizedBox(
                        height: mySize(25, 25, 50, 50, 50),
                        width: mySize(25, 25, 50, 50, 50),
                        child: CircularProgressIndicator(
                            color: colors(context).kprimaryColor),
                      ),
                    ),
                errorWidget: (context, url, error) => SvgPicture.asset(
                      unLoadedImage,
                      height: mySize(65, 65, 100, 100, 100),
                    )),
          ),
          if (expand)
            SizedBox(
              height: mySize(5, 5, 15, 15, 15),
            ),
          SizedBox(
              width: expand
                  ? mySize((screenWidth / 3) - 30, (screenWidth / 3) - 30, null,
                      null, null)
                  : null,
              child: Text(
                "language_iso".tr == "ar" ? category.nameAlt ?? "" : category.name ?? "",
                maxLines: 2,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
