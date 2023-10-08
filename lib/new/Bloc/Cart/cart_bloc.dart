import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';
import 'package:shakosh/new/Data/Local/CartLocal.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<NewCartEvent, CartState> {
  List<ProductModel> cart = [];

  double total = 0;
  double totalDiscount = 0;
  double totalTax = 0;
  double net = 0;
  CartLocal cartLocal = CartLocal();

  CartBloc() : super(CartInitial(cart: [])) {
    on<NewCartEvent>((event, emit) async {
      if (event is AddToCartEvent) {
        await addToCart(event, emit);
      } else if (event is RemoveFromCartEvent) {
        await removeFromCart(event, emit);
      } else if (event is GetLocalCartEvent) {
        emit(CartInitial(cart: []));
        cart = event.cart;
        calcNet();
        emit(GetLocalCartState(cart: cart));
      }
    });
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
      emit(CartLoading(cart: cart, id: event.product.id!));
      cartLocal.getCart();
      if (i > -1) {
        double newCartQty = cart[i].cart + cart[i].stepOrderQuantity;
        if (newCartQty <= cart[i].maxOrderQuantity) {
          cart[i].cart = newCartQty;
        }
      } else {
        cart.add(event.product);
        cart.last.cart += cart.last.stepOrderQuantity;
      }
      calcNet();
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
      emit(CartLoading(cart: cart, id: event.product.id!));
      cartLocal.getCart();
      if (i > -1) {
        double newCartQty = cart[i].cart - cart[i].stepOrderQuantity;
        if (newCartQty >= cart[i].minOrderQuantity && !event.remove) {
          cart[i].cart = newCartQty;
        } else {
          cart[i].cart = 0;
          cart.removeAt(i);
        }
      }
      calcNet();
      emit(RemoveFromCartState(cart: cart));
      cartLocal.postCart(cart);
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }
}
