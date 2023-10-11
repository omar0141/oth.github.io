part of 'cart_bloc.dart';

abstract class CartState {
  List<ProductModel> cart;
  CartState({required this.cart});
}

class CartInitial extends CartState {
  CartInitial({required super.cart});
}

class CartLoading extends CartState {
  List<String> cartLoading;
  CartLoading({required this.cartLoading, required super.cart});
}

class AddToCartState extends CartState {
  AddToCartState({required super.cart});
}

class GetCartState extends CartState {
  GetCartState({required super.cart});
}

class RemoveFromCartState extends CartState {
  RemoveFromCartState({required super.cart});
}
