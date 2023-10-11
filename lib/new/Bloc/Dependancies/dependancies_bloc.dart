import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';
import 'package:shakosh/new/Data/Local/DependanciesLocal.dart';
import 'package:shakosh/new/Data/Models/BrandModel.dart';
import 'package:shakosh/new/Data/Models/DependantsModel.dart';
import 'package:shakosh/new/Data/Remote/DependanciesRemote.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:shakosh/new/Data/Models/ShippingModel.dart';
import 'package:shakosh/new/Data/Models/TagsModel.dart';
part 'dependancies_event.dart';
part 'dependancies_state.dart';

class DependanciesBloc extends Bloc<DependanciesEvent, DependanciesState> {
  DependanciesRemote _dependanciesRemote = DependanciesRemote();
  DependanciesLocal _dependanciesLocal = DependanciesLocal();
  List<CategoreyModel> parentCategories = [];
  List<CategoreyModel> allCategories = [];
  List<CategoreyModel> subCategories = [];
  String? selectedParentCatgeoryId;
  List<TagsModel> tags = [];
  List<ShippingModel> shippings = [];
  List<BrandModel> brands = [];
  late DependantsModel dependantsData;

  DependanciesBloc() : super(DependanciesLoading()) {
    on<DependanciesEvent>((event, emit) async {
      if (event is GetDependanciesEvent) {
        if (event.remote) {
          await _dependanciesRemote.getDependancies();
          await _dependanciesRemote.getHomeDependancies();
          await getData(emit);
        } else {
          await getData(emit);
        }
      } else if (event is SelectCategoryEvent) {
        selectCategory(event, emit);
      }
    });
  }

  void selectCategory(
      SelectCategoryEvent event, Emitter<DependanciesState> emit) {
    try {
      subCategories = [];
      // Get sub catgeories of parent catgeory
      for (var category in allCategories) {
        if (category.parentId == event.selectedParentCatgeoryId) {
          subCategories.add(category);
        }
      }
      // Get selected parent catgeory id
      selectedParentCatgeoryId = event.selectedParentCatgeoryId;
      //
      emit(DependanciesLoaded(
          allCategories: allCategories,
          parentCategories: parentCategories,
          childCategories: subCategories,
          brands: brands,
          dependantsData: dependantsData));
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
      emit(DependanciesFaliure());
    }
  }

  Future<void> getData(Emitter<DependanciesState> emit) async {
    await getDependancies(emit);
    await getHomeDependancies(emit);
    emit(DependanciesLoaded(
        allCategories: allCategories,
        parentCategories: parentCategories,
        childCategories: subCategories,
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
      for (var element in dependanciesHomeData["categories"]) {
        // Modeling Parent Categories
        if (element["parent_id"] == null) {
          parentCategories.add(CategoreyModel.fromJson(element));
        }
        // Modeling All Categories
        allCategories.add(CategoreyModel.fromJson(element));
      }
      // ==========================================================
      // Modeling Tags Data From Api
      for (var element in dependanciesHomeData["tags"]) {
        tags.add(TagsModel.fromJson(element));
      }
      // ==========================================================
      // Modeling Tags Data From Api
      for (var element in dependanciesHomeData["shipping"]) {
        shippings.add(ShippingModel.fromJson(element));
      }
      // ==========================================================
      // Modeling Brands Data From Api
      for (var element in dependanciesHomeData["brands"]) {
        brands.add(BrandModel.fromJson(element));
      }
      //
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
      emit(DependanciesFaliure());
    }
  }
}
