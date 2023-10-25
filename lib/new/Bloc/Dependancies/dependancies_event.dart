part of 'dependancies_bloc.dart';

abstract class DependanciesEvent {}

class GetDependanciesEvent extends DependanciesEvent {
  final bool remote;

  GetDependanciesEvent({required this.remote});
}

class SelectCategoryEvent extends DependanciesEvent {
  SelectCategoryEvent({this.selectedParentCatgeoryId});
  String? selectedParentCatgeoryId;
}

class SelectBrandsFromCategory extends DependanciesEvent {
  SelectBrandsFromCategory({this.id});
  String? id;
}

class SelectCategoriesFromBrand extends DependanciesEvent {
  SelectCategoriesFromBrand({this.id});
  String? id;
}
