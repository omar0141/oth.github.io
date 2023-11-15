import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/Components/snakbars.dart';
import 'package:shakosh/Data/Local/FavouriteLocal.dart';
import 'package:shakosh/Data/Models/ProductModel.dart';
import 'package:shakosh/Data/Remote/FavouriteRemote.dart';
import 'package:universal_html/html.dart' as html;
part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<ProductModel> favourite = [];
  List<String> favouriteLoading = [];
  FavouriteLocal favouriteLocal = FavouriteLocal();
  FavouriteRemote favouriteRemote = FavouriteRemote();

  FavouriteBloc() : super(FavouriteInitial(favourite: [])) {
    on<FavouriteEvent>((event, emit) async {
      if (event is AddToFavouriteEvent) {
        await addToFavourite(event, emit);
      } else if (event is RemoveFromFavouriteEvent) {
        await removeFromFavourite(event, emit);
      } else if (event is GetLocalFavouriteEvent) {
        getLocalFavourite(emit, event);
      } else if (event is GetRemoteFavouriteEvent) {
        await getRemoteFavourite(emit);
      }
    });
  }

  Future<void> getRemoteFavourite(Emitter<FavouriteState> emit) async {
    List<dynamic> favouriteJson = await favouriteRemote.getFavourite();
    clearFavourite();
    for (var item in favouriteJson) {
      item["favourite"] = true;
      favourite.add(ProductModel.fromJson(item));
    }
    favouriteLocal.postFavourite(favourite);
    emit(GetFavouriteState(favourite: favourite));
  }

  void getLocalFavourite(
      Emitter<FavouriteState> emit, GetLocalFavouriteEvent event) {
    emit(FavouriteInitial(favourite: []));
    favourite = event.favourite;
    emit(GetFavouriteState(favourite: favourite));
  }

  void clearFavourite() {
    favourite.clear();
    html.window.localStorage['favourite'] = "[]";
  }

  Future addToFavourite(
    AddToFavouriteEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    try {
      emit(FavouriteLoading(favourite: favourite, id: event.product.id!));
      favouriteLocal.getFavourite();
      bool mangeFavouriteSuccess = true;
      mangeFavouriteSuccess = await favouriteRemote.manageFavourite(
          productId: event.product.id!, wishlist: "1");
      if (mangeFavouriteSuccess) favourite.add(event.product);
      emit(AddToFavouriteState(favourite: favourite));
      favouriteLocal.postFavourite(favourite);
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }

  Future removeFromFavourite(
    RemoveFromFavouriteEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    try {
      emit(FavouriteLoading(favourite: favourite, id: event.product.id!));
      favouriteLocal.getFavourite();
      bool mangeFavouriteSuccess = true;
      mangeFavouriteSuccess = await favouriteRemote.manageFavourite(
          productId: event.product.id!, wishlist: "0");
      if (mangeFavouriteSuccess)
        favourite.removeWhere((e) => e.id == event.product.id);
      emit(RemoveFromFavouriteState(favourite: favourite));
      favouriteLocal.postFavourite(favourite);
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }
}
