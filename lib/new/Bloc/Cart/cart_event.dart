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
  bool setState;
  GetLocalCartEvent({required this.cart, required this.setState});
}

class GetRemoteCartEvent extends CartEvent {
  GetRemoteCartEvent();
}

class CheckoutCartEvent extends CartEvent {
  String paymentId;
  String addressId;
  String order;
  String pickup;
  String? branchId;
  CheckoutCartEvent(
      {required this.addressId,
      required this.paymentId,
      this.order = "1",
      this.pickup = "0"});
}
