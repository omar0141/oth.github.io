import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Categories/categories_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Categories/Components/Body.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  static String routeName = "/categories";

  @override
  Widget build(BuildContext context) {
    String? parentId = BlocProvider.of<CategoriesBloc>(context).selectedId;
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: Body(
          parentId: parentId,
        ),
      );
    } else {
      return ScaffoldMobile(
        screenName: "categories".tr,
        child: Body(
          parentId: parentId,
        ),
      );
    }
  }
}
