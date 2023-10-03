import 'package:fluro/fluro.dart';
import 'package:shakosh/new/Screens/Categories/CategoriesScreen.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler _homeHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => HomeScreen());

  static Handler _categoriesHandlerWtihId = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => CategoriesScreen(
            parentId: params["id"][0],
          ));
  static Handler _categoriesHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          CategoriesScreen(parentId: null));

  static void setupRouter() {
    router.define(HomeScreen.routeName, handler: _homeHandler);
    router.define(CategoriesScreen.routeName,
        handler: _categoriesHandlerWtihId);
    router.define("categories", handler: _categoriesHandler);
  }
}
