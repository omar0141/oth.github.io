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
  GetProductsEvent(
      {this.page,
      this.order,
      this.stockOnly,
      this.dealId,
      this.brandId,
      this.categoryId,
      this.search,this.trending = false});
}
