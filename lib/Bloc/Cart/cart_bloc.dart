import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/snakbars.dart';
import 'package:shakosh/Data/Local/CartLocal.dart';
import 'package:shakosh/Data/Models/ProductModel.dart';
import 'package:shakosh/Data/Remote/CartRemote.dart';
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
        await checkout(emit, event);
      }
    });
  }

  Future<void> checkout(
      Emitter<CartState> emit, CheckoutCartEvent event) async {
    if (net > 0) {
      emit(CheckoutCartLoading(cart: cart));
      bool checkoutSuccess = await cartRemote.checkout(
          paymentId: event.paymentId,
          pickup: event.pickup,
          addressId: event.addressId,
          order: event.order);
      if (checkoutSuccess) {
        clearCart();
        calcNet();
        Navigator.of(navigatorKey.currentContext!).pop();
      }
      emit(CheckoutCartLoaded(cart: cart));
    }
  }

  Future<void> getRemoteCart(Emitter<CartState> emit) async {
    List<dynamic> cartJson = await cartRemote.getCart();
    clearCart();
    for (var item in cartJson) {
      item["cart"] = double.parse((item['quantity'] ?? 0).toString());
      cart.add(ProductModel.fromJson(item));
    }
    calcNet();
    cartLocal.postCart(cart);
    emit(GetCartState(cart: cart));
  }

  void clearCart() {
    cart.clear();
    calcNet();
    html.window.localStorage['cart'] = "[]";
  }

  void getLocalCart(Emitter<CartState> emit, GetLocalCartEvent event) {
    emit(CartInitial(cart: []));
    cart = event.cart;
    calcNet();
    emit(GetCartState(cart: cart));
  }

  void calcNet() {
    total = 0;
    totalDiscount = 0;
    totalTax = 0;
    net = 0;
    for (var product in cart) {
      total += product.price * product.cart;
      totalDiscount += product.discountValue * product.cart;
      totalTax += product.taxValue * product.cart;
      net += product.netPrice * product.cart;
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
          event.product.cart = 0;
          cart.add(event.product);
          cart.last.cart += cart.last.stepOrderQuantity;
        }
      }
      calcNet();
      cartLoading.remove(event.product.id!);
      cartLocal.postCart(cart);
      emit(AddToCartState(cart: cart));
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
      cartLocal.postCart(cart);
      emit(RemoveFromCartState(cart: cart));
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }
}
