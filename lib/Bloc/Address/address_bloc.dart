import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/Data/Models/AddressModel.dart';
import 'package:shakosh/Data/Remote/AddressesRemote.dart';
part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  List<AddressModel> addresses = [];
  AddressesRemote addressesRemote = AddressesRemote();

  AddressBloc() : super(AddressInitial(adresses: [])) {
    on<AddressEvent>((event, emit) async {
      if (event is GetAddressesEvent) {
        await getAddresses(emit);
      }
    });
  }

  Future<void> getAddresses(Emitter<AddressState> emit) async {
    emit(AddressesLoading(adresses: addresses));
    List addressesJson = await addressesRemote.getAddresses();
    for (var address in addressesJson) {
      addresses.add(AddressModel.fromJson(address));
    }
    emit(AddressesLoaded(adresses: addresses));
  }
}
