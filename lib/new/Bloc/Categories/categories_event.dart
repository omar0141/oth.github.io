part of 'categories_bloc.dart';

abstract class CategoriesEvent {}

class GetCategoriesEvent extends CategoriesEvent {}

class SelectCategoryEvent extends CategoriesEvent {
  SelectCategoryEvent({required this.selectedId});
  String selectedId;
}
