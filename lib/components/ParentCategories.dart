import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/Bloc/Products/products_bloc.dart';
import 'package:shakosh/Components/CategoriesShimmer.dart';
import 'package:shakosh/Components/CategoryCard.dart';
import 'package:shakosh/Components/ContextMenu.dart';
import 'package:shakosh/Config/Strings/Strings.dart';
import 'package:shakosh/Config/Translations/Translation.dart';
import 'package:shakosh/Config/Utils/SizeConfig.dart';
import 'package:shakosh/Data/Models/CategoreyModel.dart';

// ignore: must_be_immutable
class ParentCategories extends StatefulWidget {
  ParentCategories(
      {super.key, this.categoryId, this.expand = false, this.home = false});

  String? categoryId;
  bool expand;
  bool home;

  @override
  State<ParentCategories> createState() => _ParentCategoriesState();
}

class _ParentCategoriesState extends State<ParentCategories> with RouteAware {
  ScrollController scrollController = ScrollController();

  double listanimate = 0;

  @override
  void didPopNext() {
    BlocProvider.of<DependanciesBloc>(context).categories.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BlocProvider.of<DependanciesBloc>(context).add(
          SelectCategoryEvent(selectedParentCatgeoryId: widget.categoryId));
    });

    super.didPopNext();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    BlocProvider.of<DependanciesBloc>(context).categories.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BlocProvider.of<DependanciesBloc>(context).add(
          SelectCategoryEvent(selectedParentCatgeoryId: widget.categoryId));
    });
    super.initState();
  }

  @override
  void dispose() {
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
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
            if (widget.home)
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("categories");
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
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            if (widget.home)
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
                    List<CategoreyModel> categories = state.categories;
                    List<CategoreyModel> allCategories = state.allCategories;
                    return catgeoriesWidget(categories, allCategories);
                  } else {
                    return SizedBox();
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

  Widget catgeoriesWidget(
      List<CategoreyModel> categories, List<CategoreyModel> allCategories) {
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
                    selectCategory(category, allCategories, context);
                  },
                  child: CategoryCard(
                    expand: widget.expand,
                    category: category,
                    parentId: widget.categoryId,
                  ),
                ),
              );
            }),
      );
    } else
      return SizedBox(
        height: mySize(121, 121, 168, 168, 168),
        child: ListView.builder(
          itemCount: categories.length,
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
                    selectCategory(category, allCategories, context);
                  },
                  child: CategoryCard(
                    expand: widget.expand,
                    category: category,
                    parentId: widget.categoryId,
                  ),
                ),
              ),
            );
          },
        ),
      );
  }

  void selectCategory(
      CategoreyModel mycategory, List<CategoreyModel> allCategories, context) {
    List<CategoreyModel> categories = [];
    // Get sub catgeories of parent catgeory
    for (var category in allCategories) {
      if (category.parentId == mycategory.id) {
        categories.add(category);
      }
    }
    if (categories.isNotEmpty) {
      Navigator.of(context).pushNamed("categories/${mycategory.id}");
    } else {
      BlocProvider.of<ProductsBloc>(context).searchWithBrands = false;
      BlocProvider.of<DependanciesBloc>(context)
          .add(SelectCategoryEvent(selectedParentCatgeoryId: mycategory.id));
      String route = "categories/${mycategory.id}/products/1";
      Navigator.of(navigatorKey.currentContext!).pushNamed(route);
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
