import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/CategoriesShimmer.dart';
import 'package:shakosh/new/Components/CategoryCard.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Strings/Strings.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/BrandModel.dart';
import 'package:shakosh/new/Screens/Brands/BrandsScreen.dart';

// ignore: must_be_immutable
class BrandsWidget extends StatefulWidget {
  BrandsWidget({super.key, this.home = false});

  bool home;

  @override
  State<BrandsWidget> createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget> {
  ScrollController scrollController = ScrollController();

  double listanimate = 0;

  bool expand = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.home) {
      expand = true;
    }
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: mySize(10, 10, 20, 20, 20),
            ),
            if (widget.home)
              Text(
                "brands".tr,
                style: TextStyle(
                    fontSize: mySize(17, 17, 19, 19, 19),
                    fontWeight: FontWeight.bold),
              ),
            Spacer(),
            if (widget.home)
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(BrandsScreen.routeName);
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
            // InkWell(
            //   onTap: () {
            //     expand = !expand;
            //     setState(() {});
            //   },
            //   child: Row(
            //     children: [
            //       Text(
            //         "show-all".tr,
            //         style: TextStyle(
            //             fontSize: mySize(17, 17, 19, 19, 19),
            //             fontWeight: FontWeight.bold,
            //             height: 1),
            //       ),
            //       Icon(expand
            //           ? Icons.keyboard_arrow_up
            //           : Icons.keyboard_arrow_down)
            //     ],
            //   ),
            // ),
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
            if (!expand && screenWidth > 768) rightScroll(context),
            Expanded(
              child: BlocBuilder<DependanciesBloc, DependanciesState>(
                builder: (context, state) {
                  if (state is DependanciesLoading) {
                    return brandsShimmer();
                  } else if (state is DependanciesLoaded) {
                    List<BrandModel> brands = state.brands;
                    return brandsWidget(brands);
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Something Happened!")],
                    );
                  }
                },
              ),
            ),
            if (!expand && screenWidth > 768) leftScroll(context),
          ],
        ),
      ],
    );
  }

  SizedBox brandsShimmer() {
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

  Widget brandsWidget(List<BrandModel> brands) {
    if (expand) {
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
            itemCount: brands.length,
            itemBuilder: (context, i) {
              BrandModel brand = brands[i];
              String route = "brands/${brand.id}/products/1";
              return Listener(
                onPointerDown: (event) {
                  onPointerDown(event, Uri.base.origin + urlName + "/#$route");
                },
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<ProductsBloc>(context).brandId = brand.id;
                    Navigator.of(context).pushNamed(route);
                  },
                  child: CategoryCard(
                    expand: expand,
                    category: brand,
                  ),
                ),
              );
            }),
      );
    } else
      return SizedBox(
        height: mySize(100, 100, 150, 150, 150),
        child: ListView.builder(
          itemCount: brands.length,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            BrandModel brand = brands[i];
            String route = "brands/${brand.id}/products/1";
            return Padding(
              padding: EdgeInsetsDirectional.only(
                  end: 10, start: mySize(10, 10, 0, 0, 0)!),
              child: Listener(
                onPointerDown: (event) {
                  onPointerDown(event, Uri.base.origin + urlName + "/#$route");
                },
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<ProductsBloc>(context).brandId = brand.id;
                    Navigator.of(context).pushNamed(route);
                  },
                  child: CategoryCard(
                    expand: expand,
                    category: brand,
                  ),
                ),
              ),
            );
          },
        ),
      );
  }

  void selectBrand(BrandModel brand, context) {
    Navigator.of(context).pushNamed("categories/${brand.id}");
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
