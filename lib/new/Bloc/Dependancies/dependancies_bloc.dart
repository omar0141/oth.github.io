import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';
import 'package:shakosh/new/Config/Utils/ExpandFlatList.dart';
import 'package:shakosh/new/Data/Local/DependanciesLocal.dart';
import 'package:shakosh/new/Data/Models/BrandModel.dart';
import 'package:shakosh/new/Data/Models/DependantsModel.dart';
import 'package:shakosh/new/Data/Remote/DependanciesRemote.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:shakosh/new/Data/Models/ShippingModel.dart';
part 'dependancies_event.dart';
part 'dependancies_state.dart';

class DependanciesBloc extends Bloc<DependanciesEvent, DependanciesState> {
  DependanciesRemote _dependanciesRemote = DependanciesRemote();
  DependanciesLocal _dependanciesLocal = DependanciesLocal();
  List<CategoreyModel> categories = [];
  List<CategoreyModel> categoriesBreadCrumbs = [];
  List<CategoreyModel> allCategories = [];
  List<dynamic> allCategoriesJson = [];
  String? selectedParentCatgeoryId;
  List<ShippingModel> shippings = [];
  List<BrandModel> allBrands = [];
  List<BrandModel> brands = [];
  DependantsModel dependantsData = DependantsModel();

  DependanciesBloc() : super(DependanciesLoading()) {
    on<DependanciesEvent>((event, emit) async {
      if (event is GetDependanciesEvent) {
        if (event.remote) {
          await _dependanciesRemote.getHomeDependancies();
          await _dependanciesRemote.getDependancies();
          await getData(emit);
        } else {
          await getData(emit);
        }
      } else if (event is SelectCategoryEvent) {
        selectCategory(event, emit);
      } else if (event is SelectBrandsFromCategory) {
        selectBrandsFromCategory(event, emit);
      } else if (event is SelectCategoriesFromBrand) {
        selectCategoriesFromBrand(event, emit);
      }
    });
  }

  void selectCategory(
      SelectCategoryEvent event, Emitter<DependanciesState> emit) {
    try {
      emit(DependanciesLoading());
      // convert catgeories flat list to tree
      List expandedCategoriesList =
          expandFlatList(allCategoriesJson, null, "id", "parent_id");
      // get catgeories ids for breadcrumbs from catgeories tree
      List breadCrumbs = getBreadCrumbs(
          expandedCategoriesList, event.selectedParentCatgeoryId, "");
      categories = [];
      categoriesBreadCrumbs.clear();
      // Get sub catgeories of parent catgeory
      for (var category in allCategories) {
        if (category.parentId == event.selectedParentCatgeoryId) {
          categories.add(category);
        }
        // get catgeories breadcrumbs
        int i = breadCrumbs.indexWhere((e) => e == category.id);
        if (i > -1) {
          categoriesBreadCrumbs.add(category);
        }
      }
      // Get selected parent catgeory id
      selectedParentCatgeoryId = event.selectedParentCatgeoryId;
      //
      emit(DependanciesLoaded(
          allCategories: allCategories,
          categories: categories,
          categoriesBreadCrumbs: categoriesBreadCrumbs,
          allBrands: allBrands,
          brands: brands,
          dependantsData: dependantsData));
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
      emit(DependanciesFaliure());
    }
  }

  void selectBrandsFromCategory(
      SelectBrandsFromCategory event, Emitter<DependanciesState> emit) {
    try {
      emit(DependanciesLoading());
      List categoryBrands = [];
      int d = allCategories.indexWhere((e) => e.id == event.id);
      if (d > -1) {
        categoryBrands = allCategories[d].brands ?? [];
      }
      brands = [];
      // Get brands of catgeory
      for (var brand in allBrands) {
        int i = categoryBrands.indexWhere((e) => e == brand.id);
        if (i > -1) {
          brands.add(brand);
        }
      }
      emit(DependanciesLoaded(
          allCategories: allCategories,
          categories: categories,
          categoriesBreadCrumbs: categoriesBreadCrumbs,
          allBrands: allBrands,
          brands: brands,
          dependantsData: dependantsData));
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
      emit(DependanciesFaliure());
    }
  }

  void selectCategoriesFromBrand(
      SelectCategoriesFromBrand event, Emitter<DependanciesState> emit) {
    try {
      emit(DependanciesLoading());
      List brandCategories = [];
      int d = allBrands.indexWhere((e) => e.id == event.id);
      if (d > -1) {
        brandCategories = allBrands[d].categories ?? [];
      }

      categories = [];
      // Get categories of brand
      for (var category in allCategories) {
        int i = brandCategories.indexWhere((e) => e == category.id);
        if (i > -1) {
          categories.add(category);
        }
      }
      emit(DependanciesLoaded(
          allCategories: allCategories,
          categories: categories,
          categoriesBreadCrumbs: categoriesBreadCrumbs,
          allBrands: allBrands,
          brands: brands,
          dependantsData: dependantsData));
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
      emit(DependanciesFaliure());
    }
  }

  Future<void> getData(Emitter<DependanciesState> emit) async {
    await getHomeDependancies(emit);
    await getDependancies(emit);
    emit(DependanciesLoaded(
        allCategories: allCategories,
        categories: categories,
        categoriesBreadCrumbs: categoriesBreadCrumbs,
        allBrands: allBrands,
        brands: brands,
        dependantsData: dependantsData));
  }

  Future<void> getDependancies(Emitter<DependanciesState> emit) async {
    try {
      Map<String, dynamic> dependantsJsonData =
          await _dependanciesLocal.getDependancies();
      if (dependantsJsonData.isEmpty) {
        await _dependanciesRemote.getDependancies();
        dependantsJsonData = await _dependanciesLocal.getDependancies();
      }
      // Modeling Dependants Data From Api
      dependantsData = DependantsModel.fromJson(dependantsJsonData);
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
      emit(DependanciesFaliure());
    }
  }

  Future<void> getHomeDependancies(Emitter<DependanciesState> emit) async {
    try {
      Map<String, dynamic> dependanciesHomeData =
          await _dependanciesLocal.getHomeDependancies();
      if (dependanciesHomeData.isEmpty) {
        await _dependanciesRemote.getHomeDependancies();
        dependanciesHomeData = await _dependanciesLocal.getHomeDependancies();
      }
      // Modeling Categories Data From Api
      allCategoriesJson = dependanciesHomeData["categories"];
      for (var element in allCategoriesJson) {
        // Modeling parent Categories
        if (element["parent_id"] == null) {
          categories.add(CategoreyModel.fromJson(element));
        }
        // Modeling All Categories
        allCategories.add(CategoreyModel.fromJson(element));
      }
      // ==========================================================
      // Modeling Shipping Data From Api
      for (var element in dependanciesHomeData["shipping"]) {
        shippings.add(ShippingModel.fromJson(element));
      }
      // ==========================================================
      // Modeling Brands Data From Api
      for (var element in dependanciesHomeData["brands"]) {
        allBrands.add(BrandModel.fromJson(element));
        brands.add(BrandModel.fromJson(element));
      }
      //
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
      emit(DependanciesFaliure());
    }
  }
}
