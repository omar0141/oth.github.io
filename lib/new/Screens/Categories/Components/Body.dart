import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Components/CategoriesShimmer.dart';
import 'package:shakosh/new/Components/CategoryCard.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Components/ParentCategories.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body({super.key, this.parentId});
  String? parentId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ParentCategories(
          parentId: parentId,
          expand: parentId == null ? true : false,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: mySize(10, 10, 30, 30, 30)!),
          child: Divider(
            height: 5,
          ),
        ),
        ChildCategories()
      ],
    );
  }
}

class ChildCategories extends StatelessWidget {
  const ChildCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DependanciesBloc, DependanciesState>(
      builder: (context, state) {
        if (state is DependanciesLoading) {
          return categoriesShimmer();
        } else if (state is DependanciesLoaded) {
          List<CategoreyModel> categories = state.childCategories;
          return categoriesWidget(categories);
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Something Happened!")],
          );
        }
      },
    );
  }

  Widget categoriesWidget(List<CategoreyModel> categories) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mySize(10, 10, 30, 30, 30)!, vertical: 20),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mySize(130, 130, 155, 155, 155),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: mySize(2, 2, 5, 5, 7)!.toInt(),
          ),
          itemCount: categories.length,
          itemBuilder: (context, i) {
            CategoreyModel category = categories[i];
            String route = "categories/${category.id}/products/1";
            return Listener(
              onPointerDown: (event) {
                onPointerDown(event, Uri.base.origin + "/#$route");
              },
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(route);
                },
                child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CategoryCard(
                      category: category,
                    )),
              ),
            );
          }),
    );
  }

  Widget categoriesShimmer() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mySize(145, 145, 170, 170, 170),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: mySize(2, 2, 5, 5, 7)!.toInt(),
          ),
          itemCount: 14,
          itemBuilder: (context, i) {
            return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CategoriesShimmer()));
          }),
    );
  }
}
