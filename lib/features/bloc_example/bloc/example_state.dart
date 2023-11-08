part of 'example_bloc.dart';

// @immutable
abstract class ExampleState {}

class ExampleStateInitial extends ExampleState {}

class ExampleStateData extends ExampleState {
  final List<String> nomes;
  ExampleStateData({required this.nomes});
  // List<Object> get props => [nomes];
}

class AddNameListState extends ExampleState {
  final List<String> names;
  AddNameListState(this.names);
}
