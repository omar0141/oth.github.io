import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Components/ContextMenu.dart';
import 'package:shakosh/new/Config/Images/Images.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';

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
            Listener(
              onPointerDown: (event) {
                onPointerDown(
                    event, Uri.base.origin + "/#${HomeScreen.routeName}");
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      logo,
                      width: 200,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: BlocBuilder<DependanciesBloc, DependanciesState>(
                          builder: (context, state) {
                        if (state is DependanciesLoading) {
                          return loadingDropDown("loading".tr);
                        } else if (state is DependanciesLoaded) {
                          List<CategoreyModel> categories = state.allCategories;
                          return searchDropDown(categories);
                        } else {
                          return loadingDropDown("loading-failed".tr);
                        }
                      })),
                  Expanded(flex: 3, child: searchTextField()),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "client-service".tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: colors(context).grey1,
                        ),
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

  TextFormField loadingDropDown(text) {
    return TextFormField(
      initialValue: text,
      enabled: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
          suffix: Icon(Icons.arrow_drop_down)),
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

  DropdownButtonFormField<String> searchDropDown(
      List<CategoreyModel> categories) {
    return DropdownButtonFormField(
        padding: EdgeInsets.all(0),
        value: "0",
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
        ),
        items: [
          DropdownMenuItem(value: "0", child: Text("all-categories".tr)),
          for (CategoreyModel category in categories)
            DropdownMenuItem(
                value: category.id,
                child: Text(
                  "language_iso".tr == "ar" ? category.nameAlt : category.name,
                )),
        ],
        onChanged: (value) {});
  }
}
