import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

class MyDialogs {
  showdialog(BuildContext context, DialogType type, double? width, String desc,
      String title, VoidCallback? btnOkPress, VoidCallback? btnCancelPress) {
    AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            width: width ?? 300,
            dialogType: type,
            desc: desc,
            title: title,
            padding: EdgeInsets.symmetric(horizontal: 5),
            reverseBtnOrder: true,
            btnOkColor: colors(context).kprimaryColor,
            btnOkText: "ok".tr,
            btnOkOnPress: btnOkPress ?? () {},
            btnCancelColor:
                type == DialogType.error ? null : colors(context).cancelColor,
            btnCancelOnPress: type == DialogType.error
                ? null
                : btnCancelPress ??
                    () {
                      return;
                    },
            btnCancelText: type == DialogType.error ? null : "cancel".tr)
        .show();
  }
}
