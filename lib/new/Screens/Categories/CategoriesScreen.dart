import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Components/ScaffoldDesktop/ScaffoldDesktop.dart';
import 'package:shakosh/new/Components/ScaffoldMobile/ScaffoldMobile.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/Categories/Components/Body.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key, this.parentId});
  String? parentId;
  static String routeName = "categories/:id";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BlocProvider.of<DependanciesBloc>(context)
          .add(SelectCategoryEvent(selectedParentCatgeoryId: widget.parentId!));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (screenWidth > 768) {
      return ScaffoldDesktop(
        child: Body(
          parentId: widget.parentId,
        ),
      );
    } else {
      return ScaffoldMobile(
        screenName: "categories".tr,
        child: Body(
          parentId: widget.parentId,
        ),
      );
    }
  }
}
