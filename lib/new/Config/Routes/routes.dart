import 'package:fluro/fluro.dart';
import 'package:shakosh/new/Screens/Brands/BrandsScreen.dart';
import 'package:shakosh/new/Screens/Categories/CategoriesScreen.dart';
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

  static void setupRouter() {
    router.define(HomeScreen.routeName, handler: _homeHandler);
    router.define(CategoriesScreen.routeName,
        handler: _categoriesHandlerWtihId);
    router.define("categories", handler: _categoriesHandler);
    router.define(BrandsScreen.routeName, handler: _brandsHandler);
    // products
    router.define(ProductsScreen.productsOnlyRoute,
        handler: _productsOnlyHandler);
    router.define(ProductsScreen.productsRoute, handler: _productsHandler);
    router.define(ProductsScreen.productsSearchRoute,
        handler: _productsSearchHandler);
    router.define(ProductsScreen.productsCategoriesRoute,
        handler: _productsCategoriesHandler);
    router.define(ProductsScreen.productsCategoriesSearchRoute,
        handler: _productsCategoriesSearchHandler);
    router.define(ProductsScreen.productsBrandsRoute,
        handler: _productsBrandsHandler);
    router.define(ProductsScreen.productsBrandsSearchRoute,
        handler: _productsBrandsSearchHandler);
    router.define(ProductsScreen.productsCategoriesBrandsRoute,
        handler: _productsCategoriesBrandsHandler);
    router.define(ProductsScreen.productsCategoriesBrandsSearchRoute,
        handler: _productsCategoriesBrandsSearchHandler);
  }
}
