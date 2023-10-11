import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Data/Remote/UserRemote.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  TextEditingController phoneLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  TextEditingController usernameRegister = TextEditingController();
  TextEditingController addressRegister = TextEditingController();
  TextEditingController phoneRegister = TextEditingController();
  TextEditingController passwordRegister = TextEditingController();
  String areaId = "";
  String cityId = "";
  UserRemote _userRemote = UserRemote();

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoginEvent) {
        await login(emit, event);
      } else if (event is RegisterEvent) {
        await register(emit, event);
      }
    });
  }

  Future<void> register(Emitter<UserState> emit, RegisterEvent event) async {
    emit(SubmitLoadingState());
    String countryId =
        BlocProvider.of<DependanciesBloc>(navigatorKey.currentContext!)
            .dependantsData
            .countries!
            .first
            .id!;
    await _userRemote.register(
        username: event.username,
        password: event.password,
        telephone: event.tel,
        countryID: countryId,
        cityID: cityId,
        areaID: areaId,
        address: event.address);
    emit(SubmitLoadedState());
  }

  Future<void> login(Emitter<UserState> emit, LoginEvent event) async {
    emit(SubmitLoadingState());
    await _userRemote.login(username: event.username, password: event.password);
    emit(SubmitLoadedState());
  }
}
