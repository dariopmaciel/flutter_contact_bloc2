import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BlocFreezedExample extends StatelessWidget {
  const BlocFreezedExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Freezed Example')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("CASA");
          context.read<ExampleFreezedBloc>().add(
                const ExampleFreezedEvent.addName(addName: "Novo nome Freezed"),
              );
        },
        child: const Icon(Icons.add),
      ),
      // O BlocListener envolve tudo para escutar todas as ações
      // BlocListener de quem?  '<ExampleFreezedBloc, ExampleFreezedState>'
      body: BlocListener<ExampleFreezedBloc, ExampleFreezedState>(
        listener: (BuildContext context, state) {
          //ação designada para oq ele escuta. O estado -> ExampleFreezedState -> criar estado
          state.whenOrNull(
            showBanner: (_, message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            },
          );
        },
        child: Column(children: [
          //--------------Loader------------- veja 'ExampleFreezedBloc' -> emit(ExampleFreezedState.loading());
          BlocSelector<ExampleFreezedBloc, ExampleFreezedState, bool>(
            selector: (state) {
              return state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );
              // if (state is ExampleStateInitial) {
              //   return true;
              // }
              // return false;
            },
            builder: (context, showLoader) {
              if (showLoader) {
                return const Expanded(
                  child: Center(
                    child: SpinKitSpinningLines(color: Colors.blue, size: 180),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          //-----------Lista de itens--------------------------
          BlocSelector<ExampleFreezedBloc, ExampleFreezedState, List<String>>(
            selector: (state) {
              return state.maybeWhen(
                data: (names) => names,
                showBanner: (names, _) => names,
                orElse: () => <String>[],
              );
            },
            builder: (_, names) {
              // print('build Names!!!!!');
              return ListView.builder(
                itemCount: names.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final name = names[index];
                  return ListTile(
                    onTap: () {
                      //
                    },
                    title: Text(name),
                  );
                },
              );
            },
          ),
        ]),
      ),
    );
  }
}
