import 'package:flutter/material.dart';
import 'package:flutter_contact_bloc/features/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:flutter_contact_bloc/widgets/loader.dart';

class ContactsListCubitPage extends StatelessWidget {
  const ContactsListCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Cubit'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              children: [
                Loader<ContactListCubit, ContactListCubitState>(
                  selector: (state) {
                    return state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
