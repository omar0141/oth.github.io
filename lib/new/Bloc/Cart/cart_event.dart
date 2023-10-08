part of 'cart_bloc.dart';

abstract class NewCartEvent {}

class AddToCartEvent extends NewCartEvent {
  ProductModel product;
  AddToCartEvent({required this.product});
}

class RemoveFromCartEvent extends NewCartEvent {
  ProductModel product;
  bool remove;
  RemoveFromCartEvent({required this.product, this.remove = false});
}

class GetLocalCartEvent extends NewCartEvent {
  List<ProductModel> cart;
  GetLocalCartEvent({required this.cart});
}
