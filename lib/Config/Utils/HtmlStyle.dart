import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';

Map<String, String>? htmlStyle(element, BuildContext context) {
  Color p = colors(context).kprimaryColor!;
  String prim = "rgba(${p.red},${p.green},${p.blue}, 1)";
  Map<String, String> def = new Map.from({
    "padding": "0",
    "margin": "0",
    "gap": "0",
    "border": "none",
    "box-sizing": "border-box",
  });
  switch (element.localName) {
    case 'table':
      def["border-collapse"] = "collapse";
      break;
    case 'td':
    case 'th':
      def["border"] = "1px solid ${prim}";
      def["padding"] = "10px";
      def["valign"] = "middle";
      break;
    case 'ul':
      def["padding-inline-start"] = "25px";
      break;
  }

  return def;
}
