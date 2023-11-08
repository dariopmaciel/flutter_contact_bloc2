import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc/example_bloc.dart';

class BlocExample extends StatelessWidget {
  BlocExample({super.key});

  @override
  Widget build(BuildContext context) {
    // final exampleBloc = ExampleBloc();
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Example')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ExampleBloc>().add(ExampleAddNameEvent(casa: "FOI"));
        },
        child: const Icon(Icons.add),
      ),
      //BLOC LISNER MANTEM O CHILD SEPARADO E APOS EXECUTAR O CHILD, USAR O LISTNER PARA FAZER OQ É MANDADO
//---------------------BlocListener----------------------------------
      body: BlocListener<ExampleBloc, ExampleState>(
        // este metodo 'listenWhen' tem em todos os bloc (menos o 'Selector') e define QUANDO ele será executado. Já o 'Consumer' tem o buildWhen
        listenWhen: (previous, current) {
          if (previous is ExampleStateInitial && current is ExampleStateData) {
            if (current.nomes.length > 3) {
              return true;
            }
          }
          return false;
        },
        listener: (BuildContext context, state) async {
          print('Estado alterado após 5 segundos!!!!');
          if (state is ExampleStateData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('A quantidade de nomes é ${state.nomes.length}'),
              ),
            );
          }
        },
        child: Column(
          children: [
            // BlocConsumer<ExampleBloc, ExampleState>(
            //   buildWhen: (previous, current) {
            //     if (previous is ExampleStateInitial &&
            //         current is ExampleStateData) {
            //       if (current.nomes.length > 3) {
            //         return true;
            //       }
            //     }
            //     return false;
            //   },
            //   listener: (context, state) {
            //     print("Estado alterado para ${state.runtimeType}");
            //   },
            //   builder: (context, state) {
            //     if (state is ExampleStateData) {
            //       return Column(
            //         children: [
            //           Container(color: Colors.red, width: 300, height: 5),
            //           Text("Total de nomes ${state.nomes.length}")
            //         ],
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
            BlocSelector<ExampleBloc, ExampleState, bool>(
              selector: (state) {
                if (state is ExampleStateInitial) {
                  return true;
                }
                return false;
              },
              builder: (context, showLoader) {
                if (showLoader) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            BlocSelector<ExampleBloc, ExampleState, List<String>>(
              selector: (state) {
                if (state is ExampleStateData) {
                  return state.nomes;
                } else {
                  return [];
                }
              },
              builder: (context, nomes) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: nomes.length,
                  itemBuilder: (context, index) {
                    final names = nomes[index];
                    return ListTile(
                      onTap: () {
                        context
                            .read<ExampleBloc>()
                            .add(ExampleRemoveNameEvent(nome: names));
                      },
                      title: Text(names),
                    );
                  },
                );
              },
            ),
            // TextButton(
            //   onPressed: () {
            //     context
            //         .read<ExampleBloc>()
            //         .add(ExampleAddNameEvent(name: 'FOI .....'));
            //   },
            //   child: const Text(
            //     "ADD",
            //     style: TextStyle(color: Colors.blue),
            //   ),
            // ),
            //----------------------BlocBuilder---------------------------------
            // BlocBuilder<ExampleBloc, ExampleState>(
            //   builder: (context, state) {
            //     if (state is ExampleStateData) {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: state.nomes.length,
            //         itemBuilder: (context, index) {
            //           final names = state.nomes[index];
            //           return ListTile(
            //             title: Text(names),
            //           );
            //         },
            //       );
            //     }
            //     return const Center(
            //       child: Text('Nenhum nome Cadastrado!'),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
