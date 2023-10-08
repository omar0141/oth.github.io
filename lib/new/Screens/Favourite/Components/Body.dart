import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Components/ProductsWidget.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        List<ProductModel> products = state.favourite;
        return Column(
          children: [
            if (screenWidth > 768)
              SizedBox(
                height: 20,
              ),
            if (screenWidth > 768)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "favourite".tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )
                ],
              ),
            if (screenWidth > 768)
              SizedBox(
                height: 20,
              ),
            ProductsWidget(products: products),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
