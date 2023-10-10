part of 'user_bloc.dart';

abstract class UserEvent {}

class LoadingEvent extends UserEvent {}

class LoginEvent extends UserEvent {}

class RegisterEvent extends UserEvent {}
