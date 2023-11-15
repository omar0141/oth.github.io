import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/default_button.dart';
import 'package:shakosh/Config/Translations/Translation.dart';

class MyDialogs {
  showdialog(BuildContext context, DialogType type, double? width, String desc,
      String title, VoidCallback? btnOkPress, VoidCallback? btnCancelPress,
      {String? buttonOkText}) {
    AwesomeDialog(
      context: context,
      dismissOnTouchOutside: false,
      width: width ?? 300,
      dialogType: type,
      desc: desc,
      title: title,
      padding: EdgeInsets.symmetric(horizontal: 5),
      reverseBtnOrder: true,
      btnOk: dialogActionButton(
          context,
          buttonOkText ?? "ok".tr,
          colors(context).kprimaryColor,
          colors(context).whiteColor,
          btnOkPress ?? () {}),
      btnCancel: dialogActionButton(context, "cancel".tr, colors(context).grey2,
          colors(context).kprimaryColor, btnCancelPress ?? () {}),
    ).show();
  }

  SizedBox dialogActionButton(context, text, backColor, textColor, press) {
    return SizedBox(
      height: 35,
      child: DefaultButton(
        backcolor: backColor,
        text: text,
        forecolor: textColor,
        fontsize: 14,
        press: () {
          Navigator.of(context).pop();
          press();
        },
      ),
    );
  }
}
