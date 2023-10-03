part of 'dependancies_bloc.dart';

abstract class DependanciesState {}

class DependanciesLoading extends DependanciesState {}

class DependanciesLoaded extends DependanciesState {
  List<CategoreyModel> allCategories;
  List<CategoreyModel> parentCategories;
  List<CategoreyModel> childCategories;
  DependanciesLoaded(
      {required this.allCategories,
      required this.parentCategories,
      required this.childCategories});
}

class DependanciesFaliure extends DependanciesState {}
