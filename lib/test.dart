import 'package:flutter/material.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

class Test extends StatelessWidget {
  Test({super.key});

  static String routeName = "/test";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("welcome".tr),
              MaterialButton(
                  child: Text("lang-change".tr),
                  onPressed: () async {
                    if (Translations.currentLocale == "en") {
                      await Translations.setLocale("ar");
                    } else {
                      await Translations.setLocale("en");
                    }
                  })
            ],
          ),
        ],
      ),
    );
  }
}
