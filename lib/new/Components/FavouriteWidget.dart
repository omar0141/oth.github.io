import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';

// ignore: must_be_immutable
class FavouriteWidget extends StatelessWidget {
  FavouriteWidget(
      {super.key,
      this.height,
      this.iconSize,
      this.width,
      required this.product});

  double? iconSize;
  double? width;
  double? height;
  ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        if (state is FavouriteInitial) {
          return Container();
        } else {
          List<ProductModel> favourite = state.favourite;
          int i = favourite.indexWhere((e) => e.id == product.id);
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (i > -1) {
                  BlocProvider.of<FavouriteBloc>(context)
                      .add(RemoveFromFavouriteEvent(product: product));
                } else {
                  BlocProvider.of<FavouriteBloc>(context)
                      .add(AddToFavouriteEvent(product: product));
                }
              },
              child: Container(
                width: width ?? 35,
                height: height ?? 35,
                decoration: BoxDecoration(
                    color: colors(context).whiteColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: colors(context).kprimaryColor!)),
                child: Center(
                  child: Icon(
                    i > -1 ? Icons.favorite : Icons.favorite_outline,
                    size: iconSize ?? 22,
                    color: colors(context).kprimaryColor,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
