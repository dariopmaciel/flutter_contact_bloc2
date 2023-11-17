import 'package:flutter/material.dart';

import 'package:flutter_contact_bloc/models/contact_model.dart';

class ContactUpdatePage extends StatefulWidget {
  ContactModel contato;
  ContactUpdatePage({Key? key, required this.contato}) : super(key: key);

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEC;
  late final TextEditingController _emailEC;

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameEC = TextEditingController(text: widget.contato.name);
    _emailEC = TextEditingController(text: widget.contato.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
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
                    // context.read<ContactRegisterBloc>().add(
                    //       ContactRegisterEvent.save(
                    //         name: _nameEC.text,
                    //         email: _emailEC.text,
                    //       ),
                    //     );
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
