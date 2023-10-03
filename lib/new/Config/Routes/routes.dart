import 'package:shakosh/new/Screens/Categories/CategoriesScreen.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';
import 'package:shakosh/new/Screens/OnBoarding/OnBoardingScreen.dart';
import 'package:shakosh/screens/categories/category_screen.dart';
import 'package:shakosh/screens/pre_sign/pre_sign_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:shakosh/screens/change_password/change_password_screen.dart';
import 'package:shakosh/screens/details/details_screen.dart';
import 'package:shakosh/screens/edit_profile/edit_profile_screen.dart';

import 'package:shakosh/screens/favourite/fav_screen.dart';
import 'package:shakosh/screens/forgot_password/forgot_password_screen.dart';
import 'package:shakosh/screens/myaddresses/myaddress_screen.dart';

import 'package:shakosh/screens/orders/orders_screen.dart';
import 'package:shakosh/screens/profile/profile_screen.dart';
import 'package:shakosh/screens/sign_in/sign_in_screen.dart';
import 'package:shakosh/screens/splash/splash_screen.dart';
import 'package:shakosh/screens/google_map.dart';
import 'package:shakosh/screens/paymob.dart';
import 'package:shakosh/test.dart';

import '../../../screens/address/address_screen.dart';
import '../../../screens/sign_up/sign_up_screen.dart';
import '../../../screens/cart/cart_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  AddressScreen.routeName: (context) => AddressScreen(),
  Myaddresses.routeName: (context) => Myaddresses(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  // HomeScreen.routeName: (context) => HomeScreen(),
  Test.routeName: (context) => Test(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  MyCart.routeName: (context) => MyCart(),
  GoogleMapScreen.routeName: (context) => GoogleMapScreen(),
  PaymobScreen.routeName: (context) => PaymobScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  edit_profile.routeName: (context) => edit_profile(),
  Favourite.routeName: (context) => Favourite(),
  PreSignScreen.routeName: (context) => PreSignScreen(),
  CategoryScreen.routeName: (context) => CategoryScreen(),
  // new
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CategoriesScreen.routeName: (context) => CategoriesScreen(),
};
