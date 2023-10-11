part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class LoadingState extends UserState {}

class LoadedState extends UserState {}

class SubmitLoadingState extends UserState {}

class SubmitLoadedState extends UserState {}
