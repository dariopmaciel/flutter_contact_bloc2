import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:flutter_contact_bloc/widgets/loader.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/contact/register');
          context.read<ContactListBloc>().add(
                const ContactListEvent.findAll(),
              );
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
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
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
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ListTile(
                              onLongPress: () {
                                //DELETE
                                //Clicou e segurou, abre uma janela com a pergunta se deseja deleter o 'contact', sim ou não.
                                //
                                context.read<ContactListBloc>().add(
                                      ContactListEvent.delete(id: contact),
                                    );
                              },
                              onTap: () async {
                                await Navigator.pushNamed(
                                    context, '/contact/update',
                                    arguments: contact);
                                context.read<ContactListBloc>().add(
                                      const ContactListEvent.findAll(),
                                    );
                              },
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
