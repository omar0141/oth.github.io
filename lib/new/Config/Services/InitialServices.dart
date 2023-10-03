import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';

class InitialServices {
  Future getDependancies() async {
    if (newDate > 10) {
      BlocProvider.of<DependanciesBloc>(navigatorKey.currentContext!)
          .add(GetDependanciesEvent(remote: true));
    } else {
      BlocProvider.of<DependanciesBloc>(navigatorKey.currentContext!)
          .add(GetDependanciesEvent(remote: false));
    }
    preferences.setString("date", DateTime.now().toString());
    timer = Timer.periodic(Duration(minutes: 3), (Timer timer) {
      preferences.setString("date", DateTime.now().toString());
    });
  }
}
