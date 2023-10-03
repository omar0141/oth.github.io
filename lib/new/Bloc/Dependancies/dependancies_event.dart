part of 'dependancies_bloc.dart';

abstract class DependanciesEvent {}

class GetDependanciesEvent extends DependanciesEvent {
  final bool remote;

  GetDependanciesEvent({required this.remote});
}

class SelectCategoryEvent extends DependanciesEvent {
  SelectCategoryEvent({required this.selectedParentCatgeoryId});
  String selectedParentCatgeoryId;
}
