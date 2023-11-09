part of 'example_freezed_bloc.dart';


@freezed
class ExampleFreezedEvent with _$ExampleFreezedEvent {
  //  factory ExampleFreezedEvent() = _ExampleFreezedEvent;
  const factory ExampleFreezedEvent.findNames() = _ExampleFreezedEventFindNames;
  const factory ExampleFreezedEvent.addName({required String addName}) = _ExampleFreezedEventAddName;
  const factory ExampleFreezedEvent.removeName(String name) = _ExampleFreezedEventRemoveName;
}