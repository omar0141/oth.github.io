part of 'dependancies_bloc.dart';

abstract class DependanciesState {}

class DependanciesLoading extends DependanciesState {}

class DependanciesLoaded extends DependanciesState {
  List<CategoreyModel> allCategories;
  List<CategoreyModel> categories;
  List<CategoreyModel> categoriesBreadCrumbs;
  List<BrandModel> allBrands;
  List<BrandModel> brands;
  DependantsModel? dependantsData;
  DependanciesLoaded(
      {required this.allCategories,
      required this.categories,
      required this.categoriesBreadCrumbs,
      required this.allBrands,
      required this.brands,
      required this.dependantsData});
}

class DependanciesFaliure extends DependanciesState {}
