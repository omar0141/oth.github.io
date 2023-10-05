import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/ProductsRemote.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRemote _productsRemote = ProductsRemote();
  List<ProductModel> trendingProducts = [];
  List<ProductModel> products = [];
  int pages = 0;
  int currentPage = 0;
  int results = 0;
  String? categoryId;
  String? brandId;

  ProductsBloc() : super(ProductsLoading()) {
    on<ProductsEvent>((event, emit) async {
      if (event is GetProductsEvent) {
        await getProdcuts(event, emit);
      }
    });
  }

  Future<void> getProdcuts(
      GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    trendingProducts = [];
    products = [];
    if (event.trending == true) {
      // Get Trending Products Data From Api
      var (pagesNew, currentPageNew, resultsNew, trendingProductsData) =
          await _productsRemote.getProducts();
      // Set my bloc data with requested data from api
      pages = pagesNew;
      currentPage = currentPageNew;
      results = resultsNew;
      // Modeling Trending Products Data From Api
      for (var product in trendingProductsData) {
        trendingProducts.add(ProductModel.fromJson(product));
      }
      emit(ProductsLoaded(products: trendingProducts));
    } else {
      // Get Products Data with my filter From Api
      var (pagesNew, currentPageNew, resultsNew, productsData) =
          await _productsRemote.getProducts(
              brandId: event.brandId,
              categoryId: event.categoryId,
              dealId: event.dealId,
              order: event.order,
              page: event.page,
              search: event.search,
              stockOnly: event.stockOnly);
      // Set my bloc data with requested data from api
      pages = pagesNew;
      currentPage = currentPageNew;
      results = resultsNew;
      // Modeling Trending Products Data From Api
      for (var product in productsData) {
        products.add(ProductModel.fromJson(product));
      }
      emit(ProductsLoaded(products: products));
    }
  }
}
