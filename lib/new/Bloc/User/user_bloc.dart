import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  String? areaId;
  String? cityId;

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
  }
}
