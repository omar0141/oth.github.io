import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Data/Local/CartLocal.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<ProductModel> cart = [];
  CartLocal cartLocal = CartLocal();

  CartBloc() : super(CartInitial(cart: [])) {
    on<CartEvent>((event, emit) async {
      if (event is AddToCartEvent) {
        await addToCart(event, emit);
      } else if (event is RemoveFromCartEvent) {
        await removeFromCart(event, emit);
      } else if (event is GetLocalCartEvent) {
        emit(CartInitial(cart: []));
        cart = event.cart;
        emit(GetLocalCartState(cart: cart));
      }
    });
  }

  Future addToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
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
    emit(AddToCartState(cart: cart));
    cartLocal.postCart(cart);
  }

  Future removeFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    int i = cart.indexWhere((e) => e.id == event.product.id);
    emit(CartLoading(cart: cart, id: event.product.id!));
    cartLocal.getCart();
    if (i > -1) {
      double newCartQty = cart[i].cart - cart[i].stepOrderQuantity;
      if (newCartQty >= cart[i].minOrderQuantity) {
        cart[i].cart = newCartQty;
      } else {
        cart[i].cart = 0;
        cart.removeAt(i);
      }
    }
    emit(RemoveFromCartState(cart: cart));
    cartLocal.postCart(cart);
  }
}
