part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  List<ProductModel> products;
   int pages ;
  int currentPage ;
  int results ;
  ProductsLoaded({required this.products,required this.currentPage,required this.pages,required this.results});
}

class TrendingProductsLoaded extends ProductsState {
  List<ProductModel> products;
  TrendingProductsLoaded({required this.products});
}

class ProductsFailure extends ProductsState {}

class ProductsDetailsLoading extends ProductsState {}

class ProductsDetailsLoaded extends ProductsState {
  ProductDetailsModel productDetails;
  List<ProductModel> productSimilars;
  ProductsDetailsLoaded(
      {required this.productDetails, required this.productSimilars});
}

class ProductsDetailsFailure extends ProductsState {}
