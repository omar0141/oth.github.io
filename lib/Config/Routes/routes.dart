import 'package:fluro/fluro.dart';
import 'package:shakosh/Screens/Brands/BrandsScreen.dart';
import 'package:shakosh/Screens/Categories/CategoriesScreen.dart';
import 'package:shakosh/Screens/ChangePassword/ChangePasswordScreen.dart';
import 'package:shakosh/Screens/EditProfile/EditProfileScreen.dart';
import 'package:shakosh/Screens/Favourite/FavouriteScreen.dart';
import 'package:shakosh/Screens/Home/HomeScreen.dart';
import 'package:shakosh/Screens/Login/LoginScreen.dart';
import 'package:shakosh/Screens/More/MoreScreen.dart';
import 'package:shakosh/Screens/OrderDetails/OrderDetailsScreen.dart';
import 'package:shakosh/Screens/Orders/OrdersScreen.dart';
import 'package:shakosh/Screens/ProductDetails/ProductDetailsScreen.dart';
import 'package:shakosh/Screens/Products/ProductsScreen.dart';
import 'package:shakosh/Screens/Register/RegisterScreen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler _homeHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => HomeScreen());
  //
  static Handler _categoriesHandlerWtihId = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => CategoriesScreen(
            categoryId: params["id"][0],
          ));
  //
  static Handler _categoriesHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          CategoriesScreen(categoryId: null));
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
  static Handler _productDetailsHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          ProductDetailsScreen(
            productId: params["Id"][0],
          ));
  //
  static Handler _favouriteHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => FavouriteScreen());
  //
  static Handler _loginHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  //
  static Handler _registerHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => RegisterScreen());
  //
  static Handler _ordersHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => OrdersScreen());
  //
  static Handler _orderDetailsHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => OrderDetailsScreen(
            orderId: params["Id"][0],
          ));
  //
  static Handler _editProfileHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          EditProfileScreen());
  //
  static Handler _changePasswordHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          ChangePasswordScreen());
  //
  static Handler _moreHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => MoreScreen());
  //
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
    router.define(ProductDetailsScreen.routeName,
        handler: _productDetailsHandler, transitionDuration: Duration.zero);
    //
    router.define(FavouriteScreen.routeName,
        handler: _favouriteHandler, transitionDuration: Duration.zero);
    router.define(LoginScreen.routeName,
        handler: _loginHandler, transitionDuration: Duration.zero);
    router.define(RegisterScreen.routeName,
        handler: _registerHandler, transitionDuration: Duration.zero);
    router.define(OrdersScreen.routeName,
        handler: _ordersHandler, transitionDuration: Duration.zero);
    router.define(OrderDetailsScreen.routeName,
        handler: _orderDetailsHandler, transitionDuration: Duration.zero);
    router.define(EditProfileScreen.routeName,
        handler: _editProfileHandler, transitionDuration: Duration.zero);
    router.define(ChangePasswordScreen.routeName,
        handler: _changePasswordHandler, transitionDuration: Duration.zero);
    router.define(MoreScreen.routeName,
        handler: _moreHandler, transitionDuration: Duration.zero);
  }
}
