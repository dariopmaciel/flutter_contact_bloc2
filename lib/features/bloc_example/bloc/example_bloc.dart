import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'example_event.dart';
part 'example_state.dart';

// OBSERVAÇÃO IMPORTANTE => O BLOC + EVENT + STATE SÃO 1 ARQUIVO SÓ!!!!
// USAR 'part' e 'extends Bloc' no bloce
// E part of' no event e state

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleStateInitial()) {
    on<ExampleFindNameEvent>(_findNames);
  }
}

FutureOr<void> _findNames(
  ExampleFindNameEvent event,
  Emitter<ExampleState> emitter,
) async {
  final names = [
    'Rodrigo Rahmanm',
    'Academia do Flutter',
    'Flutter',
    'Dart',
    'Flutter Bloc',
    
  ];
  await Future.delayed(const Duration(seconds: 4));
  emitter(ExampleStateData(nomes: names));
}
