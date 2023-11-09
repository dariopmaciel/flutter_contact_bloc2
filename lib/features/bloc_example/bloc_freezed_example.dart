import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';

class BlocFreezedExample extends StatelessWidget {
  const BlocFreezedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Freezed'),
      ),
      body: Column(children: [
        BlocSelector<ExampleFreezedBloc, ExampleFreezedState, List<String>>(
          selector: (state) {
            return state.maybeWhen(
              data: (names) => names,
              orElse: () => <String>[],
            );
          },
          builder: (_, names) {
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
    );
  }
}
