part of 'products_bloc.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {
  String? page;
  String? light;
  String? order;
  String? stockOnly;
  String? price_only;
  String? dealId;
  String? brandId;
  String? categoryId;
  String count;
  String? search;
  bool trending;
  bool back;
  GetProductsEvent(
      {this.page,
      this.light,
      this.order,
      this.stockOnly,
      this.price_only,
      this.dealId,
      this.brandId,
      this.categoryId,
      required this.count,
      this.search,
      this.trending = false,
      this.back = false});
}

class GetProductDetailsEvent extends ProductsEvent {
  String? productID;
  GetProductDetailsEvent({this.productID});
}

class ProductsNavigate extends ProductsEvent {
  String? brandId;
  String? categoryId;
  String? search;
  String? page;
  ProductsNavigate(
      {this.brandId, this.categoryId, this.search, this.page = "1"});
}
