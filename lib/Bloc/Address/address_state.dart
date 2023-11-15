part of 'address_bloc.dart';

abstract class AddressState {
  List<AddressModel> adresses;
  AddressState({required this.adresses});
}

class AddressInitial extends AddressState {
  AddressInitial({required super.adresses});
}

class AddressesLoading extends AddressState {
  AddressesLoading({required super.adresses});
}

class AddressesLoaded extends AddressState {
  AddressesLoaded({required super.adresses});
}

class AddressesSubmitLoaded extends AddressState {
  AddressesSubmitLoaded({required super.adresses});
}

class AddressesSubmitLoading extends AddressState {
  AddressesSubmitLoading({required super.adresses});
}
