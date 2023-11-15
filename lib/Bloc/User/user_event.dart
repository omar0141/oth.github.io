part of 'user_bloc.dart';

abstract class UserEvent {}

class LoginEvent extends UserEvent {
  String username;
  String password;
  LoginEvent({required this.password, required this.username});
}

class RegisterEvent extends UserEvent {
  String username;
  String password;
  String tel;
  String address;
  String cityId;
  RegisterEvent(
      {required this.password,
      required this.username,
      required this.address,
      required this.cityId,
      required this.tel});
}

class GetUserData extends UserEvent {}

class UpdateUserData extends UserEvent {
  String username;
  String tel;
  UpdateUserData({required this.username, required this.tel});
}

class UpdateUserPassword extends UserEvent {
  String password;
  UpdateUserPassword({required this.password});
}

class LogoutEvent extends UserEvent {}
