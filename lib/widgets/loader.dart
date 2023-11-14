import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//VEJA generics

//CRIAÇÃO DE COMPONENTE GENÉRICS - tipos genéricos

//Explicação : "StateStreamable<S>" Bloc extendes de StateStreamable<S>.
//Como verificar isto? Entrar em dentro de bloc

//RECEBE-SE UM 'BLOC' SEJA QUAL FOR E UM 'ESTADO' SEJA QUAL FOR
class Loader<Bloc extends StateStreamable<Selector>, Selector> extends StatelessWidget {
  final BlocWidgetSelector<Selector, bool> selector;

  // const Loader({super.key, required this.selector});
  const Loader({Key? key, required this.selector}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<Bloc, Selector, bool>(
      selector: selector,
      builder: (context, loading) {
        return  Visibility(
          //definir a visibilidade é FUNDAMENTAL!!!!
          visible: loading,
          child: const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
