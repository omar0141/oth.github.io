part of 'orders_bloc.dart';

abstract class OrdersState {
  List<OrderModel> orders;
  String selectedStatus;
  OrdersState({required this.orders, required this.selectedStatus});
}

class OrdersInitial extends OrdersState {
  OrdersInitial({required super.orders, required super.selectedStatus});
}

class OrdersLoading extends OrdersState {
  OrdersLoading({required super.orders, required super.selectedStatus});
}

class OrdersLoaded extends OrdersState {
  OrdersLoaded({required super.orders, required super.selectedStatus});
}

class OrderDetailsLoaded extends OrdersState {
  List<ProductModel> products;
  OrderDetailsLoaded(
      {required super.orders,
      required super.selectedStatus,
      required this.products});
}

class OrdersSubmitLoading extends OrdersState {
  OrdersSubmitLoading({required super.orders, required super.selectedStatus});
}

class OrdersSubmitLoaded extends OrdersState {
  OrdersSubmitLoaded({required super.orders, required super.selectedStatus});
}
