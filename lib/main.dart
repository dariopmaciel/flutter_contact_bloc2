import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc_example.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:flutter_contact_bloc/features/bloc_example/bloc_freezed_example.dart';
import 'package:flutter_contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:flutter_contact_bloc/features/contacts/list/contacts_list_page.dart';
import 'package:flutter_contact_bloc/features/contacts/register/bloc/contact_register_bloc.dart';
import 'package:flutter_contact_bloc/features/contacts/register/contact_register_page.dart';
import 'package:flutter_contact_bloc/features/contacts/update/bloc/contact_update_bloc.dart';
import 'package:flutter_contact_bloc/features/contacts/update/contact_update_page.dart';

import 'package:flutter_contact_bloc/home/home_page.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';

import 'package:flutter_contact_bloc/repositories/contacts_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Envolvendo o 'MaterialApp' com o 'RepositoryProvider', disponibiliza-se o 'ContactsRepository()' para toda a árvore de componentes. Sendo necessário ser recebido em 'ContactListBloc'
    return RepositoryProvider(
      create: (BuildContext context) => ContactsRepository(),
      child: MaterialApp(
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
          '/bloc/bloc_example': (_) => BlocProvider(
              // O castate notation '...add' propicia iniciar um evento 'ExampleFindNameEvent'
              create: (_) => ExampleBloc()..add(ExampleFindNameEvent()),
              child: const BlocExample()),
          '/bloc/freezed_example': (context) => BlocProvider(
              create: (context) => ExampleFreezedBloc()
                //A adição de evento garante o carregamento da lista de itens
                ..add(const ExampleFreezedEvent.findNames()),
              child: const BlocFreezedExample()),
          '/contact/list': (context) => BlocProvider(
              create: (_) => ContactListBloc(
                  repository: context.read<ContactsRepository>())
                ..add(ContactListEvent.findAll()),
              child: const ContactsListPage()),
          // '/contact/register': (context) => const ContactRegisterPage(),
          '/contact/register': (context) => BlocProvider(
              create: (context) => ContactRegisterBloc(
                    contactRepository: context.read(),
                  ),
              child: const ContactRegisterPage()),
          '/contact/update': (context) {
            //
            final contato =
                ModalRoute.of(context)!.settings.arguments as ContactModel;
            //
            return BlocProvider(
              create: (context) =>
                  ContactUpdateBloc(contactRepository: context.read()),
              child: ContactUpdatePage(
                contato: contato,
              ),
            );
          },
        },
      ),
    );
  }
}
