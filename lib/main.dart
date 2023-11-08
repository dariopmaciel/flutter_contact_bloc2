import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc_example.dart';
import 'package:flutter_contact_bloc/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      // home: HomePage(),
      routes: {
        '/home': (_) => const HomePage(),
        '/bloc/example/': (_) => BlocProvider(
          // O castate notation '...add' propicia iniciar um evento 'ExampleFindNameEvent'
              create: (_) => ExampleBloc()..add(ExampleFindNameEvent()),
              child:  BlocExample(),
            ),
      },
    );
  }
}
