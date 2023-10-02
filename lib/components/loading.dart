import 'package:flutter/material.dart';

import '../helper/translation.dart';

class Loading {
  showloading(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Translation.get('loading')),
                    CircularProgressIndicator()
                  ],
                ),
              ));
        });
  }
}
