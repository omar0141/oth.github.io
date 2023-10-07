import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Data/Models/ProductDetailsModel.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/ProductsRemote.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRemote _productsRemote = ProductsRemote();
  List<ProductModel> trendingProducts = [];
  List<ProductModel> products = [];
  List<ProductModel> productSimilars = [];
  ProductDetailsModel productDetails = ProductDetailsModel(media: []);
  int pages = 1;
  int currentPage = 1;
  int results = 0;
  String? categoryId;
  String? brandId;
  String? search;

  ProductsBloc() : super(ProductsLoading()) {
    on<ProductsEvent>((event, emit) async {
      if (event is GetProductsEvent) {
        await getProdcuts(event, emit);
      } else if (event is GetProductDetailsEvent) {
        await getProductDetails(emit, event);
      }
    });
  }

  Future<void> getProductDetails(
      Emitter<ProductsState> emit, GetProductDetailsEvent event) async {
    emit(ProductsDetailsLoading());
    if (!event.back) {
      // Get Product Details Data From Api
      var (mediaNew, productDetailsNew) =
          await _productsRemote.getProductDetails(event.productID);
      // Modeling Product Details Data From Api
      productDetails = ProductDetailsModel.fromJson(
          Map<String, dynamic>.from(productDetailsNew));
      productDetails.media = mediaNew;
      // Get Product Similars Data From Api
      productSimilars.clear();
      List<dynamic> productSimilarsNew =
          await _productsRemote.getSimilarProducts(event.productID);
      // Modeling Product Similars Data From Api
      for (var product in productSimilarsNew) {
        productSimilars.add(ProductModel.fromJson(product));
      }
    }
    //
    emit(ProductsDetailsLoaded(
        productDetails: productDetails, productSimilars: productSimilars));
  }

  Future<void> getProdcuts(
      GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    if (event.trending == true) {
      if (!event.back) {
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
      }
      emit(TrendingProductsLoaded(products: trendingProducts));
    } else {
      if (!event.back) {
        products = [];
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
      }
      emit(ProductsLoaded(
          products: products,
          currentPage: currentPage,
          pages: pages,
          results: results));
    }
  }
}
