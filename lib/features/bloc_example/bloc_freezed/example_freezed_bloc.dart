import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_freezed_state.dart';
part 'example_freezed_event.dart';
part 'example_freezed_bloc.freezed.dart';

class ExampleFreezedBloc
    extends Bloc<ExampleFreezedEvent, ExampleFreezedState> {
  ExampleFreezedBloc() : super(ExampleFreezedState.initial()) {
    on<_ExampleFreezedEventAddName>(_addNames);
    on<_ExampleFreezedEventRemoveName>(_removeName);
    on<_ExampleFreezedEventFindNames>(_findNames);
  }
//---------------ADD--------------------------
  FutureOr<void> _addNames(
    _ExampleFreezedEventAddName event,
    Emitter<ExampleFreezedState> emit,
  ) {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[],
    );
    final newName = [...names];
    newName.add(event.addName);
    emit(ExampleFreezedState.data(names: names));
    //
    // final stateExample = state;
    // if (stateExample is ExampleStateData) {
    //   final names = [...stateExample.nomes, event.addnome];
    //   // names.add(event.name); // Adicione o novo nome à lista
    //   emit(ExampleStateData(
    //       nomes: names)); // Emita o novo estado com o nome adicionado
    // }
  }

//---------------REMOVE--------------------------

  FutureOr<void> _removeName(
    _ExampleFreezedEventRemoveName event,
    Emitter emit,
  ) {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[],
    );
    final newNames = [...names];
    newNames.retainWhere((element) => element != event.name);
    emit(ExampleFreezedState.data(names: newNames));
  }

  //atribuido para uma variavel local para poder remover este cast '(state as ExampleStateData)'
  //pois variaveis locais fazem auto promoção do tipo
  // final stateExample = state;
  // if (state is ExampleStateData) {
  //   (state as ExampleStateData).nomes;
  // }
  // if (stateExample is ExampleStateData) {
  //necessário fazer spreadOperator pois quando se remove se faz na mesma instancia, mesma lista. O SpreadOperator cria uma segunda lista comparativa
  // final names = [...stateExample.nomes];
  // names.retainWhere((element) => element != event.nome);
  // emit(ExampleStateData(nomes: names));
  // }

//---------------FIND--------------------------
  FutureOr<void> _findNames(
    _ExampleFreezedEventFindNames event,
    Emitter<ExampleFreezedState> emit,
  ) async {
    emit(ExampleFreezedState.loading());
    final names = [
      'Rodrigo Rahmanm',
      'Academia do Flutter',
      'Flutter',
      'Dart',
      'Flutter Bloc',
    ];
    
    
    await Future.delayed(const Duration(seconds: 2));
    emit(ExampleFreezedState.data(names: names));
  }
}
