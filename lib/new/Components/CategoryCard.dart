import 'package:fast_cached_network_image/fast_cached_network_image.dart';
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
      width: mySize(100, 100, 150, 150, 150),
      decoration: BoxDecoration(
          color: parentId == category.id
              ? colors(context).grey2!.withOpacity(0.5)
              : null,
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FastCachedImage(
                height: mySize(65, 65, 100, 100, 100),
                width: mySize(65, 65, 100, 100, 100),
                url: MyApi.media + (category.thumbnail ?? ""),
                loadingBuilder: (context, url) => SizedBox(
                      height: mySize(65, 65, 100, 100, 100),
                      width: mySize(65, 65, 100, 100, 100),
                      child: Center(
                        child: SizedBox(
                          height: mySize(25, 25, 50, 50, 50),
                          width: mySize(25, 25, 50, 50, 50),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                errorBuilder: (context, url, error) => SvgPicture.asset(
                      unLoadedImage,
                      height: mySize(65, 65, 100, 100, 100),
                    )),
          ),
          SizedBox(
            height: mySize(4, 4, 15, 15, 15),
          ),
          SizedBox(
              width: expand
                  ? mySize((screenWidth / 3) - 30, (screenWidth / 3) - 30, null,
                      null, null)
                  : null,
              child: Text(
                "language_iso".tr == "ar"
                    ? category.nameAlt ?? ""
                    : category.name ?? "",
                maxLines: 2,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
