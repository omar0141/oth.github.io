// ignore_for_file: non_constant_identifier_names, file_names

class MyApi {
  static String base = "https://dev.exabytellc.com/_/Exa/BE/ERP/";
  static String api = MyApi.base + "API/";
  static String media = MyApi.api + "_media/";
  static String SID = "d3hhZmdQdkRrYnlKOktJdmdSWFVQamZZSnRlWDVqZm5wMXc9PQ==";
  static String BranchId = "";
  static String AddressId = "";
  static String CID = '';
  static String facebook =
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=';
  static String login = MyApi.api + 'public/ecommerce/clients/login';
  static String postFirebase =
      MyApi.api + "public/ecommerce/clients/firebase-token";
  static String register = MyApi.api + "public/ecommerce/clients/signup";
  static String resetPassword =
      MyApi.api + 'public/ecommerce/clients/reset-password';
  static String getAddresses =
      MyApi.api + 'public/ecommerce/clients/addresses/get';
  static String AddAddress =
      MyApi.api + 'public/ecommerce/clients/addresses/add';
  static String UpdateAddress =
      MyApi.api + 'public/ecommerce/clients/addresses/update';
  static String deleteAddress =
      MyApi.api + 'public/ecommerce/clients/addresses/delete';
  static String postLogin = MyApi.api + 'public/ecommerce/clients/post-login';
  static String Dependants = MyApi.api + 'public/ecommerce/dependants';
  static String CategoryProducts =
      MyApi.api + 'public/ecommerce/products/get-categories';
  static String ProductDetails =
      MyApi.api + 'public/ecommerce/products/details';
  static String ProductSimilars =
      MyApi.api + 'public/ecommerce/products/similar';
  static String ProductVariants =
      MyApi.api + 'public/ecommerce/products/variants';
  static String Products = MyApi.api + 'public/ecommerce/products/get';
  static String Categories = MyApi.api + 'public/ecommerce/home';
  static String AddToCart = MyApi.api + 'public/ecommerce/clients/cart/manage';
  static String AddToWishlist =
      MyApi.api + 'public/ecommerce/clients/wishlist/manage';
  static String BatchCart = MyApi.api + 'public/ecommerce/clients/cart/batch';
  static String BatchWishlist =
      MyApi.api + 'public/ecommerce/clients/wishlist/batch';
  static String GetCart = MyApi.api + 'public/ecommerce/clients/cart/get';
  static String GetWishlist =
      MyApi.api + 'public/ecommerce/clients/wishlist/get';
  static String ChangePassword =
      MyApi.api + 'public/ecommerce/clients/set-password';
  static String Checkout = MyApi.api + 'public/ecommerce/clients/checkout';
  static String EditProfile = MyApi.api + 'public/ecommerce/clients/update';
  static String DeleteProfile = MyApi.api + 'public/ecommerce/clients/delete';
  static String GetOrders = MyApi.api + 'public/ecommerce/clients/orders/get';
  static String CancelOrders =
      MyApi.api + 'public/ecommerce/clients/orders/cancel';
}
