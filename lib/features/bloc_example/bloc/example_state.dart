part of 'example_bloc.dart';

// @immutable
abstract class ExampleState {}

class ExampleStateInitial extends ExampleState{}

class ExampleStateData extends ExampleState{
  final List<String> nomes;
  ExampleStateData({
    required this.nomes,
  });
}
