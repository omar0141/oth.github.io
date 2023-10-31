import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Data/Models/ProductDetailsModel.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
import 'package:shakosh/new/Data/Remote/ProductsRemote.dart';
import 'package:universal_html/html.dart' as html;
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRemote _productsRemote = ProductsRemote();
  List<ProductModel> trendingProducts = [];
  List<ProductModel> products = [];
  List<ProductModel> productSimilars = [];
  late ProductDetailsModel productDetails;
  int pages = 1;
  int currentPage = 1;
  int results = 0;
  bool searchWithBrands = false;

  ProductsBloc() : super(ProductsLoading()) {
    on<ProductsEvent>((event, emit) async {
      if (event is GetProductsEvent) {
        await getProdcuts(event, emit);
      } else if (event is GetProductDetailsEvent) {
        await getProductDetails(emit, event);
      } else if (event is ProductsNavigate) {
        productsNavigate(event);
      }
    });
  }

  void productsNavigate(ProductsNavigate event) {
    String route = "";
    if (event.brandId != null) {
      route =
          "brands/${event.brandId}/products/${event.page}/${event.search ?? ""}";
    }
    if (event.categoryId != null) {
      route =
          "categories/${event.categoryId}/products/${event.page}/${event.search ?? ""}";
    }
    if (event.brandId != null && event.categoryId != null) {
      route =
          "categories/${event.categoryId}/brands/${event.brandId}/products/${event.page}/${event.search ?? ""}";
    }
    if (event.brandId == null && event.categoryId == null) {
      route = "products/${event.page}/${event.search ?? ""}";
    }
    html.window.history.replaceState(null, '', "#$route");
    Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(route);
  }

  Future<void> getProductDetails(
      Emitter<ProductsState> emit, GetProductDetailsEvent event) async {
    emit(ProductsDetailsLoading());
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
    //
    emit(ProductsDetailsLoaded(
        productDetails: productDetails, productSimilars: productSimilars));
  }

  Future<void> getProdcuts(
      GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    if (event.trending == true) {
      if (!event.back) {
        trendingProducts = [];
        // Get Trending Products Data From Api
        var (pagesNew, currentPageNew, resultsNew, trendingProductsData) =
            await _productsRemote.getProducts(count: event.count);
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
                count: event.count,
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
