import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/new/Data/Api/CategoriesApi.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesApi _categoriesApi = CategoriesApi();
  List<CategoreyModel> parentCategories = [];
  List<CategoreyModel> allCategories = [];
  List<CategoreyModel> childCategories = [];
  String? selectedId;

  CategoriesBloc() : super(CategoriesLoading()) {
    on<CategoriesEvent>((event, emit) async {
      if (event is GetCategoriesEvent) {
        List<dynamic> categoriesApiData = await _categoriesApi.getCategories();
        for (var element in categoriesApiData) {
          if (element["parent_id"] == null) {
            parentCategories.add(CategoreyModel.fromJson(element));
          }
          allCategories.add(CategoreyModel.fromJson(element));
        }
        emit(CategoriesLoaded(
            parentCategories: parentCategories,
            childCategories: childCategories));
      } else if (event is SelectCategoryEvent) {
        childCategories = [];
        for (var category in allCategories) {
          if (category.parentId == event.selectedId) {
            childCategories.add(category);
          }
        }
        selectedId = event.selectedId;
        emit(CategoriesLoaded(
            parentCategories: parentCategories,
            childCategories: childCategories));
      }
    });
  }
}
