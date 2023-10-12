import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Data/Models/OrderModel.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/OrdersRemote.dart';
part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  List<OrderModel> orders = [];
  List<OrderModel> ordersDataSource = [];
  OrdersRemote ordersRemote = OrdersRemote();
  String selectedStatus = "processing";
  List<String> statusTypes = [
    "processing",
    "shipping",
    "arrived",
    "canceled"
  ];

  OrdersBloc() : super(OrdersInitial(orders: [], selectedStatus: "")) {
    on<OrdersEvent>((event, emit) async {
      if (event is GetOrdersEvent) {
        await getOrders(emit);
      } else if (event is FilterOrdersEvent) {
        filterOrders(emit, event);
      } else if (event is GetOrderDetailsEvent) {
        await getOrderDetails(emit, event);
      }
    });
  }

  Future<void> getOrderDetails(
      Emitter<OrdersState> emit, GetOrderDetailsEvent event) async {
    emit(OrdersLoading(orders: orders, selectedStatus: selectedStatus));
    List<dynamic> productsJson =
        await ordersRemote.getOrderDetails(orderId: event.id);
    List<ProductModel> products = [];
    for (var product in productsJson) {
      products.add(ProductModel.fromJson(product));
    }
    emit(OrderDetailsLoaded(
        orders: orders, selectedStatus: selectedStatus, products: products));
  }

  void filterOrders(Emitter<OrdersState> emit, FilterOrdersEvent event) {
    emit(OrdersLoading(
        orders: ordersDataSource, selectedStatus: selectedStatus));
    ordersDataSource.clear();
    for (var order in orders) {
      if (order.status == selectedStatus) {
        ordersDataSource.add(order);
      }
    }
    emit(
        OrdersLoaded(orders: ordersDataSource, selectedStatus: selectedStatus));
  }

  Future<void> getOrders(Emitter<OrdersState> emit) async {
    emit(OrdersLoading(
        orders: ordersDataSource, selectedStatus: statusTypes.first));
    orders.clear();
    ordersDataSource.clear();
    List<dynamic> ordersJson = await ordersRemote.getOrders();
    for (var order in ordersJson) {
      orders.add(OrderModel.fromJson(order));
      if (order["status"] == "processing") {
        ordersDataSource.add(OrderModel.fromJson(order));
      }
    }
    emit(OrdersLoaded(
        orders: ordersDataSource, selectedStatus: statusTypes.first));
  }
}
