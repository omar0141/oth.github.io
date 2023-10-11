import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/dialogs.dart';
import 'package:shakosh/new/Components/snakbars.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Local/CartLocal.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/CartRemote.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:universal_html/html.dart' as html;
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<ProductModel> cart = [];
  List<String> cartLoading = [];
  double total = 0;
  double totalDiscount = 0;
  double totalTax = 0;
  double net = 0;
  CartLocal cartLocal = CartLocal();
  CartRemote cartRemote = CartRemote();

  CartBloc() : super(CartInitial(cart: [])) {
    on<CartEvent>((event, emit) async {
      if (event is AddToCartEvent) {
        await addToCart(event, emit);
      } else if (event is RemoveFromCartEvent) {
        await removeFromCart(event, emit);
      } else if (event is GetLocalCartEvent) {
        getLocalCart(emit, event);
      } else if (event is GetRemoteCartEvent) {
        await getRemoteCart(emit);
      } else if (event is CheckoutCartEvent) {
        if (net > 0) {
          if (MyApi.UID != "") {
            clearCart();
          } else {
            MyDialogs().showdialog(
                navigatorKey.currentContext!,
                DialogType.infoReverse,
                mySize(320, 320, 400, 400, 400),
                "you-need-to-sign-in-first".tr,
                "sorry".tr,
                () {},
                null,
                buttonOkText: "sign-in".tr);
          }
        }
      }
    });
  }

  Future<void> getRemoteCart(Emitter<CartState> emit) async {
    List<dynamic> cartJson = await cartRemote.getCart();
    clearCart();
    for (var item in cartJson) {
      item["cart"] = double.parse((item['quantity'] ?? 0).toString());
      cart.add(ProductModel.fromJson(item));
    }
    cartLocal.postCart(cart);
    emit(GetCartState(cart: cart));
  }

  void clearCart() {
    cart.clear();
    html.window.localStorage['cart'] = "[]";
  }

  void getLocalCart(Emitter<CartState> emit, GetLocalCartEvent event) {
    if (event.setState) {
      emit(CartInitial(cart: []));
      cart = event.cart;
      calcNet();
      emit(GetCartState(cart: cart));
    } else {
      cart = event.cart;
    }
  }

  void calcNet() {
    total = 0;
    totalDiscount = 0;
    totalTax = 0;
    net = 0;
    for (var product in cart) {
      total += product.price;
      totalDiscount += product.discountValue;
      totalTax += product.taxValue;
      net += product.netPrice;
    }
  }

  Future addToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      int i = cart.indexWhere((e) => e.id == event.product.id);
      cartLoading.add(event.product.id!);
      emit(CartLoading(cart: cart, cartLoading: cartLoading));
      cartLocal.getCart();
      bool mangeCartSuccess = false;
      if (i > -1) {
        double newCartQty = cart[i].cart + cart[i].stepOrderQuantity;
        if (newCartQty <= cart[i].maxOrderQuantity) {
          mangeCartSuccess = await cartRemote.manageCart(
              productId: event.product.id!, productQty: newCartQty.toString());
          if (mangeCartSuccess) cart[i].cart = newCartQty;
        }
      } else {
        mangeCartSuccess = await cartRemote.manageCart(
            productId: event.product.id!,
            productQty: event.product.stepOrderQuantity.toString());
        if (mangeCartSuccess) {
          cart.add(event.product);
          cart.last.cart += cart.last.stepOrderQuantity;
        }
      }
      calcNet();
      cartLoading.remove(event.product.id!);
      emit(AddToCartState(cart: cart));
      cartLocal.postCart(cart);
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  Future removeFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      int i = cart.indexWhere((e) => e.id == event.product.id);
      cartLoading.add(event.product.id!);
      emit(CartLoading(cart: cart, cartLoading: cartLoading));
      cartLocal.getCart();
      bool mangeCartSuccess = false;
      if (i > -1) {
        double newCartQty = cart[i].cart - cart[i].stepOrderQuantity;
        if (newCartQty >= cart[i].minOrderQuantity && !event.remove) {
          mangeCartSuccess = await cartRemote.manageCart(
              productId: event.product.id!, productQty: newCartQty.toString());
          if (mangeCartSuccess) {
            cart[i].cart = newCartQty;
          }
        } else {
          mangeCartSuccess = await cartRemote.manageCart(
              productId: event.product.id!, productQty: "0");
          if (mangeCartSuccess) {
            cart[i].cart = 0;
            cart.removeAt(i);
          }
        }
      }
      calcNet();
      cartLoading.remove(event.product.id!);
      emit(RemoveFromCartState(cart: cart));
      cartLocal.postCart(cart);
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }
}
