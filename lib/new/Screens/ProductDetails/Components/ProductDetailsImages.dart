import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductDetailsModel.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';

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
          if (screenWidth > 768)
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
                child: Listener(
                  onPointerDown: (event) {
                    onPointerDown(
                        event,
                        MyApi.media +
                            (productDetails.media[index]["filename"]));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: currentPage == index
                                ? colors(context).kprimaryColor!
                                : colors(context).grey2!)),
                    width: mySize(40, 40, 75, 75, 75),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: FastCachedImage(
                          fit: BoxFit.contain,
                          url: MyApi.media +
                              (productDetails.media[index]["filename"]),
                          loadingBuilder: (context, url) => Center(
                                child: SizedBox(
                                  width: mySize(20, 20, 35, 35, 35),
                                  height: mySize(20, 20, 35, 35, 35),
                                  child: CircularProgressIndicator(
                                      color: colors(context).kprimaryColor),
                                ),
                              ),
                          errorBuilder: (context, url, error) =>
                              SvgPicture.asset(
                                unLoadedImage,
                                height: mySize(40, 40, 75, 75, 75),
                              )),
                    ),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: colors(context).grey2!)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: mySize(screenHeight * 0.3, screenHeight * 0.3,
                screenHeight * 0.4, screenHeight * 0.4, screenHeight * 0.4),
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
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: Stack(
                            children: [
                              SizedBox(
                                width: mySize(
                                    screenWidth,
                                    screenWidth,
                                    screenWidth * 0.5,
                                    screenWidth * 0.5,
                                    screenWidth * 0.5),
                                height: mySize(
                                    screenWidth,
                                    screenWidth,
                                    screenWidth * 0.5,
                                    screenWidth * 0.5,
                                    screenWidth * 0.5),
                                child: InteractiveViewer(
                                  // panEnabled: false, // Set it to false
                                  boundaryMargin: EdgeInsets.all(100),
                                  minScale: 1,
                                  maxScale: 8,
                                  child: FastCachedImage(
                                      url: MyApi.media + (image["filename"]),
                                      loadingBuilder: (context, url) => Center(
                                            child: SizedBox(
                                              width: screenHeight * 0.25,
                                              height: screenHeight * 0.25,
                                              child: CircularProgressIndicator(
                                                  color: colors(context)
                                                      .kprimaryColor),
                                            ),
                                          ),
                                      errorBuilder: (context, url, error) =>
                                          SvgPicture.asset(
                                            unLoadedImage,
                                            height: screenHeight * 0.4,
                                          )),
                                ),
                              ),
                              Positioned(
                                  child: IconButton(
                                hoverColor: Colors.transparent,
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ))
                            ],
                          ),
                        );
                      });
                },
                child: Listener(
                  onPointerDown: (event) {
                    onPointerDown(event, MyApi.media + (image["filename"]));
                  },
                  child: FastCachedImage(
                      url: MyApi.media + (image["filename"]),
                      loadingBuilder: (context, url) => Center(
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
                      errorBuilder: (context, url, error) => SvgPicture.asset(
                            unLoadedImage,
                            height: mySize(
                                screenHeight * 0.3,
                                screenHeight * 0.3,
                                screenHeight * 0.4,
                                screenHeight * 0.4,
                                screenHeight * 0.4),
                          )),
                ),
              )
          ],
        ),
      ),
    );
  }
}
