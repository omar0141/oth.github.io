part of 'MyApp_bloc.dart';

@freezed
class MyAppEvent with _$MyAppEvent {
  const factory MyAppEvent.changeAppState() = _ChangeAppState;
}
