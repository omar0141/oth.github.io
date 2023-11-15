// ignore_for_file: non_constant_identifier_names, file_names

class MyApi {
  static String base = "https://dev.exabytellc.com/_/Exa/BE/ERP/";
  static String api = MyApi.base + "API/";
  static String media = MyApi.api + "_media/";
  static String SID = "MHBZM0ZIdldoV1Q0bFE9PTpjK3F6dGtPVk5HZGhSZ29pYUFwMkZBPT0=";
  static String UID = "";
  static String username = "";
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
  static String addAddress =
      MyApi.api + 'public/ecommerce/clients/addresses/add';
  static String UpdateAddress =
      MyApi.api + 'public/ecommerce/clients/addresses/update';
  static String deleteAddress =
      MyApi.api + 'public/ecommerce/clients/addresses/delete';
  static String postLogin = MyApi.api + 'public/ecommerce/clients/post-login';
  static String dependants = MyApi.api + 'public/ecommerce/dependants';
  static String CategoryProducts =
      MyApi.api + 'public/ecommerce/products/get-categories';
  static String productDetails =
      MyApi.api + 'public/ecommerce/products/details';
  static String productSimilars =
      MyApi.api + 'public/ecommerce/products/similar';
  static String ProductVariants =
      MyApi.api + 'public/ecommerce/products/variants';
  static String products = MyApi.api + 'public/ecommerce/products/get';
  static String home = MyApi.api + 'public/ecommerce/home';
  static String manageCart = MyApi.api + 'public/ecommerce/clients/cart/manage';
  static String manageWishlist =
      MyApi.api + 'public/ecommerce/clients/wishlist/manage';
  static String batchCart = MyApi.api + 'public/ecommerce/clients/cart/batch';
  static String batchWishlist =
      MyApi.api + 'public/ecommerce/clients/wishlist/batch';
  static String getCart = MyApi.api + 'public/ecommerce/clients/cart/get';
  static String getWishlist =
      MyApi.api + 'public/ecommerce/clients/wishlist/get';
  static String changePassword =
      MyApi.api + 'public/ecommerce/clients/set-password';
  static String checkout = MyApi.api + 'public/ecommerce/clients/checkout';
  static String updateUser = MyApi.api + 'public/ecommerce/clients/update';
  static String DeleteProfile = MyApi.api + 'public/ecommerce/clients/delete';
  static String getOrders = MyApi.api + 'public/ecommerce/clients/orders/get';
  static String getOrderDetails =
      MyApi.api + 'public/ecommerce/clients/orders/details';
  static String CancelOrders =
      MyApi.api + 'public/ecommerce/clients/orders/cancel';
}
