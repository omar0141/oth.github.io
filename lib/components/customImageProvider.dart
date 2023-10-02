// ignore_for_file: avoid_print, file_names
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class MyImages {
  static Map<String?, Uint8List?> images = {};

  static Future add(String? url) async {
    if (MyImages.images[url] != null) return;
    try {
      http.Response response = await http.get(Uri.parse(url!));
      if (response.statusCode == 200) {
        MyImages.images[url] = response.bodyBytes;
      } else {
        MyImages.images[url] = null;
      }
    } catch (e) {
      debugPrint(e.toString());
      MyImages.images[url] = null;
    }
  }
}

class CustomImageProvider extends StatefulWidget {
  final String? imageSource;
  final BoxFit fit;
  const CustomImageProvider(
      {Key? key, this.imageSource, this.fit = BoxFit.fill})
      : super(key: key);

  @override
  _CustomImageProviderState createState() => _CustomImageProviderState();
}

class _CustomImageProviderState extends State<CustomImageProvider> {
  final String _loading = 'assets/loading2.gif';
  final String _unLoaded = 'assets/icons/unloaded.svg';
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        getImageFromUrl();
        if (loading == true) {
          return Image.asset(_loading);
        } else if (MyImages.images[widget.imageSource] == null) {
          return SvgPicture.asset(_unLoaded);
        } else if (widget.imageSource == null) {
          return SvgPicture.asset(_unLoaded);
        } else {
          return Image.memory(
            MyImages.images[widget.imageSource]!,
            fit: widget.fit,
          );
        }
      },
    );
  }

  void getImageFromUrl() async {
    await MyImages.add(widget.imageSource).whenComplete(() {
      if (mounted) setState(() => loading = false);
    });
  }
}
