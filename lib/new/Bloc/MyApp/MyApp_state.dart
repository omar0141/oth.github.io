part of 'MyApp_bloc.dart';

@freezed
class MyAppState with _$MyAppState {
  const factory MyAppState.init() = _Initial;
  const factory MyAppState.setState() = _SetState;
}