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
    on<ExampleRemoveNameEvent>(_removeNames);
    on<ExampleAddNameEvent>(_addName);
  }

  FutureOr<void> _removeNames(
      ExampleRemoveNameEvent event, Emitter<ExampleState> emit) {
    //atribuido para uma variavel local para poder remover este cast '(state as ExampleStateData)'
    //pois variaveis locais fazem auto promoção do tipo
    final stateExample = state;
    // if (state is ExampleStateData) {
    //   (state as ExampleStateData).nomes;
    // }
    if (stateExample is ExampleStateData) {
      //necessário fazer spreadOperator pois quando se remove se faz na mesma instancia, mesma lista. O SpreadOperator cria uma segunda lista comparativa
      final names = [...stateExample.names];
      names.retainWhere((element) => element != event.nome);
      emit(ExampleStateData(names: names));
    }
  }

  FutureOr<void> _findNames(
      ExampleFindNameEvent event, Emitter<ExampleState> emitter) async {
    final names = [
      'Rodrigo Rahmanm',
      'Academia do Flutter',
      'Flutter',
      'Dart',
      'Flutter Bloc',
    ];
    await Future.delayed(const Duration(seconds: 1));
    emitter(ExampleStateData(names: names));
  }

  FutureOr<void> _addName(
    ExampleAddNameEvent event,
    Emitter<ExampleState> emit,
  ) {
    final stateExample = state;
    if (stateExample is ExampleStateData) {
      final names = [...stateExample.names];
      names.add(event.addnome);
      emit(ExampleStateData(names: names));
      // final names = [...stateExample.names, event.addnome];
      // names.add(event.name); // Adicione o novo nome à lista
      // Emita o novo estado com o nome adicionado
      // emit(ExampleStateData(names: names));
    }
  }
}
