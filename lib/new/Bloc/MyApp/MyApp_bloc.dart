import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'MyApp_state.dart';
part 'MyApp_event.dart';
part 'MyApp_bloc.freezed.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  MyAppBloc() : super(const MyAppState.init()) {
    on<MyAppEvent>((event, emit) async {
      event.map(changeAppState: (state) {
        emit(MyAppState.setState());
        emit(MyAppState.init());
      });
    });
  }
}
