part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  List<ProductModel> products;
  ProductsLoaded({required this.products});
}

class ProductsFailure extends ProductsState {}
