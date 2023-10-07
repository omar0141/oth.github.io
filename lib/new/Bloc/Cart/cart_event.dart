part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddNewToCartEvent extends CartEvent {
  ProductModel product;
  AddNewToCartEvent({required this.product});
}

class AddToCartEvent extends CartEvent {
  ProductModel product;
  AddToCartEvent({required this.product});
}

class RemoveFromCartEvent extends CartEvent {
  ProductModel product;
  RemoveFromCartEvent({required this.product});
}

class GetLocalCartEvent extends CartEvent {
  List<ProductModel> cart;
  GetLocalCartEvent({required this.cart});
}
