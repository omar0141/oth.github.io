import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Data/Models/BrandModel.dart';

// ignore: must_be_immutable
class BrandsBreadCrumbs extends StatelessWidget {
  BrandsBreadCrumbs({super.key, this.brandId});

  String? brandId;

  String getBrandName() {
    List<BrandModel> brands =
        BlocProvider.of<DependanciesBloc>(navigatorKey.currentContext!)
            .allBrands;
    int i = brands.indexWhere((e) => e.id == brandId);
    if (i > -1) {
      return ("language_iso".tr == "ar" ? brands[i].nameAlt : brands[i].name) ??
          "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Wrap(
        children: [
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("brands");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "brands".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors(context).kSecondaryColor,
                        fontSize: 17,
                        height: "language_iso".tr == "ar" ? 2 : 1),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: colors(context).grey1,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getBrandName(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colors(context).normalTextColor,
                      fontSize: 17,
                      height: "language_iso".tr == "ar" ? 2 : 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
