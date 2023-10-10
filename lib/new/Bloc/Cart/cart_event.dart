part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  ProductModel product;
  AddToCartEvent({required this.product});
}

class RemoveFromCartEvent extends CartEvent {
  ProductModel product;
  bool remove;
  RemoveFromCartEvent({required this.product, this.remove = false});
}

class GetLocalCartEvent extends CartEvent {
  List<ProductModel> cart;
  GetLocalCartEvent({required this.cart});
}

class GetRemoteCartEvent extends CartEvent {
  GetRemoteCartEvent();
}

class CheckoutCartEvent extends CartEvent {
  CheckoutCartEvent();
}
