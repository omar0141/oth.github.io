part of 'products_bloc.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {
  String? page;
  String? order;
  String? stockOnly;
  String? dealId;
  String? brandId;
  String? categoryId;
  String? search;
  bool trending;
  bool back;
  GetProductsEvent(
      {this.page,
      this.order,
      this.stockOnly,
      this.dealId,
      this.brandId,
      this.categoryId,
      this.search,
      this.trending = false,this.back = false});
}

class GetProductDetailsEvent extends ProductsEvent {
  String? productID;
  bool back;
  GetProductDetailsEvent({this.productID,this.back = false});
}
