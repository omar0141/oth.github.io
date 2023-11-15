part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class LoadingState extends UserState {}

class LoadedState extends UserState {
  UserModel user;
  LoadedState({required this.user});
}

class SubmitLoadingState extends UserState {}

class SubmitLoadedState extends UserState {}
