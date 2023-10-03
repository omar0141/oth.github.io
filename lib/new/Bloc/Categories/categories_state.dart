part of 'categories_bloc.dart';

abstract class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  List<CategoreyModel> parentCategories;
  List<CategoreyModel> childCategories;
  CategoriesLoaded({required this.parentCategories, required this.childCategories});
}

class CategoriesFaliure extends CategoriesState {}
