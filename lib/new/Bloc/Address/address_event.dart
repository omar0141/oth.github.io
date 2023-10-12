part of 'address_bloc.dart';

abstract class AddressEvent {}

class GetAddressesEvent extends AddressEvent {}

class AddAddressesEvent extends AddressEvent {}

class UpdateAddressesEvent extends AddressEvent {}

class DeleteAddressesEvent extends AddressEvent {}
