import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Components/CategoriesShimmer.dart';
import 'package:shakosh/new/Components/CategoryCard.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Strings/Strings.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:universal_html/html.dart' as html;

// ignore: must_be_immutable
class ParentCategories extends StatefulWidget {
  ParentCategories(
      {super.key, this.parentId, this.expand = false, this.categories = false});

  String? parentId;
  bool expand;
  bool categories;

  @override
  State<ParentCategories> createState() => _ParentCategoriesState();
}

class _ParentCategoriesState extends State<ParentCategories> {
  ScrollController scrollController = ScrollController();
  double listanimate = 0;
  @override
  void initState() {
    BlocProvider.of<DependanciesBloc>(context).subCategories.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: mySize(10, 10, 20, 20, 20),
            ),
            Text(
              "categories".tr,
              style: TextStyle(
                  fontSize: mySize(17, 17, 19, 19, 19),
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                widget.expand = !widget.expand;
                setState(() {});
              },
              child: Row(
                children: [
                  Text(
                    "show-all".tr,
                    style: TextStyle(
                        fontSize: mySize(17, 17, 19, 19, 19),
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  Icon(widget.expand
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down)
                ],
              ),
            ),
            SizedBox(
              width: mySize(10, 10, 20, 20, 20),
            ),
          ],
        ),
        SizedBox(
          height: mySize(10, 10, 20, 20, 20),
        ),
        Row(
          children: [
            if (!widget.expand && screenWidth > 768) rightScroll(context),
            Expanded(
              child: BlocBuilder<DependanciesBloc, DependanciesState>(
                builder: (context, state) {
                  if (state is DependanciesLoading) {
                    return categoriesShimmer();
                  } else if (state is DependanciesLoaded) {
                    List<CategoreyModel> categories = state.parentCategories;
                    return catgeoriesWidget(categories);
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Something Happened!")],
                    );
                  }
                },
              ),
            ),
            if (!widget.expand && screenWidth > 768) leftScroll(context),
          ],
        ),
      ],
    );
  }

  SizedBox categoriesShimmer() {
    return SizedBox(
        height: 150,
        child: ListView.builder(
            controller: scrollController,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoriesShimmer();
            }));
  }

  Widget catgeoriesWidget(List<CategoreyModel> categories) {
    if (widget.expand) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: mySize(10, 10, 30, 30, 30)!),
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: mySize(137, 137, 167, 167, 167),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: mySize(3, 2, 5, 5, 7)!.toInt(),
            ),
            itemCount: categories.length,
            itemBuilder: (context, i) {
              CategoreyModel category = categories[i];
              return Listener(
                onPointerDown: (event) {
                  onPointerDown(
                      event,
                      Uri.base.origin +
                          urlName +
                          "/#categories/${category.id}");
                },
                child: InkWell(
                  onTap: () {
                    selectCategory(category);
                  },
                  child: CategoryCard(
                    expand: widget.expand,
                    category: category,
                    parentId: widget.parentId,
                  ),
                ),
              );
            }),
      );
    } else
      return SizedBox(
        height: mySize(100, 100, 150, 150, 150),
        child: ListView.builder(
          itemCount:categories.length,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            CategoreyModel category = categories[i];
            return Padding(
              padding: EdgeInsetsDirectional.only(
                  end: 10, start: mySize(10, 10, 0, 0, 0)!),
              child: Listener(
                onPointerDown: (event) {
                  onPointerDown(
                      event,
                      Uri.base.origin +
                          urlName +
                          "/#categories/${category.id}");
                },
                child: InkWell(
                  onTap: () {
                    selectCategory(category);
                  },
                  child: CategoryCard(
                    expand: widget.expand,
                    category: category,
                    parentId: widget.parentId,
                  ),
                ),
              ),
            );
          },
        ),
      );
  }

  void selectCategory(CategoreyModel category) {
    if (widget.parentId == null) {
      BlocProvider.of<DependanciesBloc>(context)
          .add(SelectCategoryEvent(selectedParentCatgeoryId: category.id));
      if (!widget.categories) {
        Navigator.of(context).pushNamed("categories/${category.id}");
      } else {
        html.window.history
            .replaceState(null, 'categories', "#categories/${category.id}");
        widget.parentId = category.id;
      }
    } else {
      html.window.history
          .replaceState(null, 'categories', "#categories/${category.id}");
      widget.parentId = category.id;
      BlocProvider.of<DependanciesBloc>(context)
          .add(SelectCategoryEvent(selectedParentCatgeoryId: widget.parentId!));
    }
  }

  SizedBox leftScroll(BuildContext context) {
    return SizedBox(
      height: 150,
      child: InkWell(
        onTap: () {
          if (scrollController.position.pixels <
              scrollController.position.maxScrollExtent) {
            listanimate += screenWidth * 0.9;
          } else {
            listanimate = scrollController.position.maxScrollExtent;
          }
          scrollController.animateTo(listanimate,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: 10),
          child: Icon(
            Icons.arrow_forward_ios,
            color: colors(context).kprimaryColor,
          ),
        ),
      ),
    );
  }

  SizedBox rightScroll(BuildContext context) {
    return SizedBox(
      height: 150,
      child: InkWell(
        onTap: () {
          if (scrollController.position.pixels >
              scrollController.position.minScrollExtent) {
            listanimate -= screenWidth * 0.9;
          } else {
            listanimate = scrollController.position.minScrollExtent;
          }
          scrollController.animateTo(listanimate,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Icon(
            Icons.arrow_back_ios,
            color: colors(context).kprimaryColor,
          ),
        ),
      ),
    );
  }
}
