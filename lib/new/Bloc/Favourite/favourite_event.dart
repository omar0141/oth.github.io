part of 'favourite_bloc.dart';

abstract class FavouriteEvent {}

class AddToFavouriteEvent extends FavouriteEvent {
  ProductModel product;
  AddToFavouriteEvent({required this.product});
}

class RemoveFromFavouriteEvent extends FavouriteEvent {
  ProductModel product;
  RemoveFromFavouriteEvent({required this.product});
}

class GetLocalFavouriteEvent extends FavouriteEvent {
  List<ProductModel> favourite;
  GetLocalFavouriteEvent({required this.favourite});
}
