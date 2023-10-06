import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Components/AddToCartWidget.dart';
import 'package:shakosh/new/Components/FavouriteWidget.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductDetailsModel.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';

// ignore: must_be_immutable
class DesktopBody extends StatelessWidget {
  DesktopBody({super.key, required this.product});

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsDetailsLoaded) {
          ProductDetailsModel productDetails = state.productDetails;
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          ProductDetailsImages(
                            productDetails: productDetails,
                          )
                        ],
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "language_iso".tr == "ar"
                                      ? product.nameAlt
                                      : product.name,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "language_iso".tr == "ar"
                                      ? productDetails.briefAlt ?? ""
                                      : productDetails.brief ?? "",
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "language_iso".tr == "ar"
                                      ? productDetails.descriptionAlt ?? ""
                                      : productDetails.description ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.price.toStringAsFixed(2) +
                                      " " +
                                      "le".tr,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: colors(context).kSecondaryColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 200,
                                  height: 55,
                                  child: AddToCartWidget(
                                    fontSize: 18,
                                    iconSize: 25,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              FavouriteWidget(
                                width: 55,
                                height: 55,
                                iconSize: 30,
                              )
                            ],
                          ),
                        ],
                      ))
                ],
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

// ignore: must_be_immutable
class ProductDetailsImages extends StatefulWidget {
  ProductDetailsImages({super.key, required this.productDetails});

  ProductDetailsModel productDetails;

  @override
  State<ProductDetailsImages> createState() => _ProductDetailsImagesState();
}

class _ProductDetailsImagesState extends State<ProductDetailsImages> {
  int currentPage = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: mySize(0, 0, 30, 30, 30)!),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Builder(builder: (context) {
            return carouselImages(widget.productDetails.media);
          }),
          SizedBox(
            height: 15,
          ),
          imagesIndicator(widget.productDetails)
        ],
      ),
    );
  }

  SizedBox imagesIndicator(ProductDetailsModel productDetails) {
    return SizedBox(
      height: mySize(40, 40, 75, 75, 75),
      child: Center(
        child: ListView.builder(
          itemCount: productDetails.media.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  currentPage = index;
                  carouselController.animateToPage(currentPage,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 250));
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: currentPage == index
                              ? colors(context).kprimaryColor!
                              : colors(context).grey2!)),
                  width: mySize(40, 40, 75, 75, 75),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                        imageUrl: MyApi.media +
                            (productDetails.media[index]["filename"]),
                        placeholder: (context, url) => Center(
                              child: SizedBox(
                                width: mySize(20, 20, 35, 35, 35),
                                height: mySize(20, 20, 35, 35, 35),
                                child: CircularProgressIndicator(
                                    color: colors(context).kprimaryColor),
                              ),
                            ),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                              unLoadedImage,
                              height: mySize(40, 40, 75, 75, 75),
                            )),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container carouselImages(List<dynamic> productMedia) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: colors(context).grey2!)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: mySize(screenHeight * 0.3, screenHeight * 0.3,
                screenHeight * 0.55, screenHeight * 0.55, screenHeight * 0.55),
            enableInfiniteScroll: true,
            initialPage: currentPage,
            enlargeCenterPage: true,
            viewportFraction: 2,
            onPageChanged: (index, reason) {
              currentPage = index;
              setState(() {});
            },
          ),
          items: [
            for (var image in productMedia)
              CachedNetworkImage(
                  imageUrl: MyApi.media + (image["filename"]),
                  placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: mySize(
                              screenHeight * 0.15,
                              screenHeight * 0.15,
                              screenHeight * 0.25,
                              screenHeight * 0.25,
                              screenHeight * 0.25),
                          height: mySize(
                              screenHeight * 0.15,
                              screenHeight * 0.15,
                              screenHeight * 0.25,
                              screenHeight * 0.25,
                              screenHeight * 0.25),
                          child: CircularProgressIndicator(
                              color: colors(context).kprimaryColor),
                        ),
                      ),
                  errorWidget: (context, url, error) => SvgPicture.asset(
                        unLoadedImage,
                        height: mySize(
                            screenHeight * 0.3,
                            screenHeight * 0.3,
                            screenHeight * 0.55,
                            screenHeight * 0.55,
                            screenHeight * 0.55),
                      ))
          ],
        ),
      ),
    );
  }
}
