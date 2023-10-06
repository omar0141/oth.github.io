import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';

// ignore: must_be_immutable
class FavouriteWidget extends StatefulWidget {
  FavouriteWidget({super.key, this.height, this.iconSize, this.width});

  double? iconSize;
  double? width;
  double? height;

  @override
  State<FavouriteWidget> createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          favourite = !favourite;
          setState(() {});
        },
        child: Container(
          width: widget.width ?? 35,
          height: widget.height ?? 35,
          decoration: BoxDecoration(
              color: colors(context).whiteColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: colors(context).kprimaryColor!)),
          child: Center(
            child: Icon(
              favourite ? Icons.favorite : Icons.favorite_outline,
              size: widget.iconSize ?? 22,
              color: favourite ? Colors.red : colors(context).kprimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
