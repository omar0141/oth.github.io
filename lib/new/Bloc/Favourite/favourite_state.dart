part of 'favourite_bloc.dart';

abstract class FavouriteState {
  List<ProductModel> favourite;
  FavouriteState({required this.favourite});
}

class FavouriteInitial extends FavouriteState {
  FavouriteInitial({required super.favourite});
}

class AddToFavouriteState extends FavouriteState {
  AddToFavouriteState({required super.favourite});
}

class RemoveFromFavouriteState extends FavouriteState {
  RemoveFromFavouriteState({required super.favourite});
}

class GetLocalFavouriteState extends FavouriteState {
  GetLocalFavouriteState({required super.favourite});
}
