part of 'example_bloc.dart';

abstract class ExampleEvent {}

class ExampleFindNameEvent extends ExampleEvent {}

class ExampleRemoveNameEvent extends ExampleEvent {
  String nome;
  ExampleRemoveNameEvent({
    required this.nome,
  });
}

class ExampleAddNameEvent extends ExampleEvent {
  String addnome;
  ExampleAddNameEvent({
    required this.addnome,
  });
  
}
