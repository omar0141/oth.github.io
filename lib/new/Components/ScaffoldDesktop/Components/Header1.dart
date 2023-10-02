import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

class Header1 extends StatelessWidget {
  const Header1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 85,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                logo,
                width: 200,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 1, child: searchDropDown()),
                  Expanded(flex: 3, child: searchTextField()),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "client-service".tr,
                        style: TextStyle(
                            fontSize: 18, color: colors(context).grey1),
                      ),
                      SelectableText(
                        "(+2) 01023966756",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 20, color: colors(context).kprimaryColor),
                      ),
                      SelectableText(
                        "(+2) 01221722221",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 20, color: colors(context).kprimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextField searchTextField() {
    return TextField(
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search),
        hintText: "search-placeholder".tr,
      ),
    );
  }

  DropdownButtonFormField<String> searchDropDown() {
    return DropdownButtonFormField(
        padding: EdgeInsets.all(0),
        value: "0",
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
        ),
        items: [
          DropdownMenuItem(value: "0", child: Text("item.columnName".tr)),
        ],
        onChanged: (value) {});
  }
}
