import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Components/CatgeoriesBreadCrumbs.dart';
import 'package:shakosh/new/Components/ParentCategories.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body({super.key, this.categoryId});
  String? categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DependanciesBloc, DependanciesState>(
      builder: (context, state) {
        List<CategoreyModel> categoriesBreadCrumbs = [];
        if (state is DependanciesLoaded) {
          categoriesBreadCrumbs = state.categoriesBreadCrumbs;
        }
        return WillPopScope(
          onWillPop: () async {
            int i = categoriesBreadCrumbs.indexWhere((e) => e.id == categoryId);
            if (i > -1) {
              if (i == 0) {
                Navigator.of(context).pushReplacementNamed("categories");
                return false;
              } else {
                Navigator.of(context).pushReplacementNamed(
                    "categories/${categoriesBreadCrumbs[i - 1].id}");
                return false;
              }
            } else {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              return false;
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CatgeoriesBreadCrumbs(),
              SizedBox(
                height: 20,
              ),
              ParentCategories(
                categoryId: categoryId,
                expand: true,
              )
            ],
          ),
        );
      },
    );
  }
}
