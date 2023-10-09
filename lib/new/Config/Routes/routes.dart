import 'package:fluro/fluro.dart';
import 'package:shakosh/new/Screens/Brands/BrandsScreen.dart';
import 'package:shakosh/new/Screens/Categories/CategoriesScreen.dart';
import 'package:shakosh/new/Screens/Favourite/FavouriteScreen.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';
import 'package:shakosh/new/Screens/Products/ProductsScreen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler _homeHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => HomeScreen());
  //
  static Handler _categoriesHandlerWtihId = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => CategoriesScreen(
            parentId: params["id"][0],
          ));
  //
  static Handler _categoriesHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          CategoriesScreen(parentId: null));
  //
  static Handler _brandsHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => BrandsScreen());
  //
  static Handler _productsOnlyHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          ProductsScreen()); //
  static Handler _productsHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProductsScreen(
            page: params["pageId"][0],
          ));
  //
  static Handler _productsSearchHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProductsScreen(
            page: params["pageId"][0],
            search: params["search"][0],
          ));
  //
  static Handler _productsCategoriesHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProductsScreen(
            page: params["pageId"][0],
            categoryId: params["categoryId"][0],
          ));
  //
  static Handler _productsCategoriesSearchHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProductsScreen(
            page: params["pageId"][0],
            search: params["search"][0],
            categoryId: params["categoryId"][0],
          ));
  //
  static Handler _productsBrandsHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProductsScreen(
            page: params["pageId"][0],
            brandId: params["brandId"][0],
          ));
  //
  static Handler _productsBrandsSearchHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProductsScreen(
            page: params["pageId"][0],
            search: params["search"][0],
            brandId: params["brandId"][0],
          ));
  //
  static Handler _productsCategoriesBrandsHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProductsScreen(
            page: params["pageId"][0],
            categoryId: params["categoryId"][0],
            brandId: params["brandId"][0],
          ));
  //
  static Handler _productsCategoriesBrandsSearchHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProductsScreen(
            page: params["pageId"][0],
            search: params["search"][0],
            categoryId: params["categoryId"][0],
            brandId: params["brandId"][0],
          ));
  //
  static Handler _favouriteHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => FavouriteScreen());

  static void setupRouter() {
    router.define(HomeScreen.routeName,
        handler: _homeHandler, transitionDuration: Duration.zero);
    router.define(CategoriesScreen.routeName,
        handler: _categoriesHandlerWtihId, transitionDuration: Duration.zero);
    router.define("categories",
        handler: _categoriesHandler, transitionDuration: Duration.zero);
    router.define(BrandsScreen.routeName,
        handler: _brandsHandler, transitionDuration: Duration.zero);
    // products
    router.define(ProductsScreen.productsOnlyRoute,
        handler: _productsOnlyHandler, transitionDuration: Duration.zero);
    router.define(ProductsScreen.productsRoute,
        handler: _productsHandler, transitionDuration: Duration.zero);
    router.define(ProductsScreen.productsSearchRoute,
        handler: _productsSearchHandler, transitionDuration: Duration.zero);
    router.define(ProductsScreen.productsCategoriesRoute,
        handler: _productsCategoriesHandler, transitionDuration: Duration.zero);
    router.define(ProductsScreen.productsCategoriesSearchRoute,
        handler: _productsCategoriesSearchHandler,
        transitionDuration: Duration.zero);
    router.define(ProductsScreen.productsBrandsRoute,
        handler: _productsBrandsHandler, transitionDuration: Duration.zero);
    router.define(ProductsScreen.productsBrandsSearchRoute,
        handler: _productsBrandsSearchHandler,
        transitionDuration: Duration.zero);
    router.define(ProductsScreen.productsCategoriesBrandsRoute,
        handler: _productsCategoriesBrandsHandler,
        transitionDuration: Duration.zero);
    router.define(ProductsScreen.productsCategoriesBrandsSearchRoute,
        handler: _productsCategoriesBrandsSearchHandler,
        transitionDuration: Duration.zero);
    router.define(FavouriteScreen.routeName,
        handler: _favouriteHandler, transitionDuration: Duration.zero);
  }
}
