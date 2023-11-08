import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'example_event.dart';
part 'example_state.dart';

// OBSERVAÇÃO IMPORTANTE => O BLOC + EVENT + STATE SÃO 1 ARQUIVO SÓ!!!!
// USAR 'part' e 'extends Bloc' no bloce
// E part of' no event e state

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleStateInitial()) {
    on<ExampleFindNameEvent>(_findNames);
    on<ExampleRemoveNameEvent>(_removeNames);
    on<ExampleAddNameEvent>(_addNames);
  }

  FutureOr<void> _removeNames(ExampleRemoveNameEvent event, Emitter emit) {
    //atribuido para uma variavel local para poder remover este cast '(state as ExampleStateData)'
    //pois variaveis locais fazem auto promoção do tipo
    final stateExample = state;
    // if (state is ExampleStateData) {
    //   (state as ExampleStateData).nomes;
    // }
    if (stateExample is ExampleStateData) {
      //necessário fazer spreadOperator pois quando se remove se faz na mesma instancia, mesma lista. O SpreadOperator cria uma segunda lista comparativa
      final names = [...stateExample.nomes];
      names.retainWhere((element) => element != event.nome);
      emit(ExampleStateData(nomes: names));
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
    await Future.delayed(const Duration(seconds: 1));
    emitter(ExampleStateData(nomes: names));
  }

  FutureOr<void> _addNames(
      ExampleAddNameEvent event, Emitter<ExampleState> emit) {
    final stateExample = state;
    if (stateExample is ExampleStateData) {
      final names = [...stateExample.nomes, event.addnome];

      // names.add(event.name); // Adicione o novo nome à lista
      emit(ExampleStateData(
          nomes: names)); // Emita o novo estado com o nome adicionado
    }
  }
}
