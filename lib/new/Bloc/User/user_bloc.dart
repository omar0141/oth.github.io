import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/controller/controllers.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Data/Models/UserModel.dart';
import 'package:shakosh/new/Data/Remote/UserRemote.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  TextEditingController phoneLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  TextEditingController usernameRegister = TextEditingController();
  TextEditingController addressRegister = TextEditingController();
  TextEditingController phoneRegister = TextEditingController();
  TextEditingController passwordRegister = TextEditingController();
  UserRemote _userRemote = UserRemote();
  late UserModel user;

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoginEvent) {
        await login(emit, event);
      } else if (event is RegisterEvent) {
        await register(emit, event);
      } else if (event is GetUserData) {
        await getUserData(emit);
      } else if (event is UpdateUserData) {
        await updateUserData(emit, event);
      } else if (event is UpdateUserPassword) {
        await updateUserPassword(emit, event);
      } else if (event is LogoutEvent) {
        logout();
      }
    });
  }

  void logout() {
    MyApi.UID = "";
    MyApi.username = "";
    preferences.remove("id");
    preferences.remove("username");
    BlocProvider.of<CartBloc>(navigatorKey.currentContext!).clearCart();
    BlocProvider.of<FavouriteBloc>(navigatorKey.currentContext!).clearFavourite();
    Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(HomeScreen.routeName);
  }

  Future<void> updateUserPassword(
      Emitter<UserState> emit, UpdateUserPassword event) async {
    emit(SubmitLoadingState());
    await _userRemote.updateUserPassword(password: event.password);
    emit(SubmitLoadedState());
  }

  Future<void> updateUserData(
      Emitter<UserState> emit, UpdateUserData event) async {
    emit(SubmitLoadingState());
    await _userRemote.updateUser(tel: event.tel, username: event.username);
    emit(SubmitLoadedState());
  }

  Future<void> getUserData(Emitter<UserState> emit) async {
    emit(LoadingState());
    Map<String, dynamic> userJson = await _userRemote.postLogin();
    user = UserModel.fromJson(userJson);
    emit(LoadedState(user: user));
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
        cityID: event.cityId,
        address: event.address);
    emit(SubmitLoadedState());
  }

  Future<void> login(Emitter<UserState> emit, LoginEvent event) async {
    emit(SubmitLoadingState());
    await _userRemote.login(username: event.username, password: event.password);
    emit(SubmitLoadedState());
  }
}
