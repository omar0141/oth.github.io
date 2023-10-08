import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';
import 'package:shakosh/new/Data/Local/FavouriteLocal.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';
part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<ProductModel> favourite = [];
  FavouriteLocal favouriteLocal = FavouriteLocal();

  FavouriteBloc() : super(FavouriteInitial(favourite: [])) {
    on<FavouriteEvent>((event, emit) async {
      if (event is AddToFavouriteEvent) {
        await addToFavourite(event, emit);
      } else if (event is RemoveFromFavouriteEvent) {
        await removeFromFavourite(event, emit);
      } else if (event is GetLocalFavouriteEvent) {
        emit(FavouriteInitial(favourite: []));
        favourite = event.favourite;
        emit(GetLocalFavouriteState(favourite: favourite));
      }
    });
  }

  Future addToFavourite(
    AddToFavouriteEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    try {
      favouriteLocal.getFavourite();
      favourite.add(event.product);
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
      favouriteLocal.getFavourite();
      favourite.removeWhere((e) => e.id == event.product.id);
      emit(RemoveFromFavouriteState(favourite: favourite));
      favouriteLocal.postFavourite(favourite);
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
  }
}
