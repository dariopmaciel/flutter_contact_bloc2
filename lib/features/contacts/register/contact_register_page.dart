import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/contacts/register/bloc/contact_register_bloc.dart';
import 'package:flutter_contact_bloc/widgets/loader.dart';

class ContactRegisterPage extends StatefulWidget {
  const ContactRegisterPage({Key? key}) : super(key: key);

  @override
  State<ContactRegisterPage> createState() => _ContactRegisterPageState();
}

class _ContactRegisterPageState extends State<ContactRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameEC,
                decoration: const InputDecoration(
                  label: Text("Nome:"),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '* Nome Obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailEC,
                decoration: const InputDecoration(
                  label: Text("E-mail:"),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '* E-mail Obrigatório';
                  }
                  return null;
                },
              ),
              // const SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  final validade = _formKey.currentState?.validate() ?? false;
                  if (validade) {
                    context.read<ContactRegisterBloc>().add(
                          ContactRegisterEvent.save(
                            name: _nameEC.text,
                            email: _emailEC.text,
                          ),
                        );
                  }
                },
                child: const Text("Salvar"),
              ),
              // Loader<ContactRegisterBloc, ContactRegisterState>(
              //   selector: (state) {
              //     return state.maybeWhen(
              //       loading: () => true,
              //       orElse: () => false,
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
