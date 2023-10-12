import 'package:flutter/material.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

TextFormField loadingInput() {
  return TextFormField(
    initialValue: "loading".tr,
    enabled: false,
    decoration: InputDecoration(
      contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
    ),
  );
}
