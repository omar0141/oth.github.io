part of 'favourite_bloc.dart';

abstract class FavouriteState {
  List<ProductModel> favourite;
  FavouriteState({required this.favourite});
}

class FavouriteInitial extends FavouriteState {
  FavouriteInitial({required super.favourite});
}

class FavouriteLoading extends FavouriteState {
  String id;
  FavouriteLoading({required super.favourite,required this.id});
}

class AddToFavouriteState extends FavouriteState {
  AddToFavouriteState({required super.favourite});
}

class RemoveFromFavouriteState extends FavouriteState {
  RemoveFromFavouriteState({required super.favourite});
}

class GetFavouriteState extends FavouriteState {
  GetFavouriteState({required super.favourite});
}
