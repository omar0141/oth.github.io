import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';

// ignore: must_be_immutable
class CatgeoriesBreadCrumbs extends StatelessWidget {
  CatgeoriesBreadCrumbs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DependanciesBloc, DependanciesState>(
      builder: (context, state) {
        List<CategoreyModel> categoriesBreadCrumbs = [];
        if (state is DependanciesLoaded) {
          categoriesBreadCrumbs = state.categoriesBreadCrumbs;
        }

        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: Wrap(
            children: [
              SizedBox(
                width: 20,
              ),
              if (categoriesBreadCrumbs.isNotEmpty)
              Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: InkWell(
                    onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed("categories");
                          },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "categories".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  colors(context).kSecondaryColor,
                              fontSize: 17,
                              height:  "language_iso".tr == "ar" ? 2 : 1),
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
              for (var category in categoriesBreadCrumbs)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: InkWell(
                    onTap: category.id == categoriesBreadCrumbs.last.id
                        ? null
                        : () {
                            Navigator.of(context)
                                .pushReplacementNamed("categories/${category.id}");
                          },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ("language_iso".tr == "ar"
                                  ? category.nameAlt
                                  : category.name) ??
                              "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  category.id == categoriesBreadCrumbs.last.id
                                      ? colors(context).normalTextColor
                                      : colors(context).kSecondaryColor,
                              fontSize: 17,
                              height: "language_iso".tr == "ar" ? 2 : 1),
                        ),
                        if (category.id != categoriesBreadCrumbs.last.id)
                          Icon(
                            Icons.arrow_forward_ios,
                            color: colors(context).grey1,
                            size: 17,
                          ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
