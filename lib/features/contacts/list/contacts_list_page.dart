import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:flutter_contact_bloc/widgets/loader.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/contact/register');
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ContactListBloc, ContactListState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            error: (error) => true,
            orElse: () => false,
          );
        },
        listener: (BuildContext context, state) {
          state.maybeWhen(
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            //aqui pode dar erro
            orElse: () => false,
          );
        },
        child: RefreshIndicator(
          onRefresh: () async => context.read<ContactListBloc>()
            ..add(const ContactListEvent.findAll()),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Loader<ContactListBloc, ContactListState>(
                      selector: (state) {
                        return state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                      },
                    ),
                    BlocSelector<ContactListBloc, ContactListState,
                        List<ContactModel>>(
                      selector: (state) {
                        return state.maybeWhen(
                          data: (contacts) => contacts,
                          orElse: () => [],
                        );
                      },
                      builder: (_, contacts) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ListTile(
                              onTap: () => Navigator.pushNamed(context, '/contact/update'),
                              title: Text(contact.name),
                              subtitle: Text(contact.email),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
