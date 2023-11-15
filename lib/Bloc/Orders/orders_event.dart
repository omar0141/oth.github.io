part of 'orders_bloc.dart';

abstract class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent {}

class FilterOrdersEvent extends OrdersEvent {}

class GetOrderDetailsEvent extends OrdersEvent {
  String id;
  GetOrderDetailsEvent({required this.id});
}

class DeleteOrderEvent extends OrdersEvent {
  String id;
  DeleteOrderEvent({required this.id});
}

class CancelOrderEvent extends OrdersEvent {
  String id;
  CancelOrderEvent({required this.id});
}
