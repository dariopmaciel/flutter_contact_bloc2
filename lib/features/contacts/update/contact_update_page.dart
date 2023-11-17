import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/features/contacts/update/bloc/contact_update_bloc.dart';

import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:flutter_contact_bloc/widgets/loader.dart';

class ContactUpdatePage extends StatefulWidget {
  final ContactModel contato;

  const ContactUpdatePage({Key? key, required this.contato}) : super(key: key);

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  //QUANDO "EDIÇÃO" usar desta maneira, pois ele será inicializado depois. Ele irá receber um objeto depois de tudo inicializado
  //Para isto é necessário instanciar um objeto da classe 'Contactmodel', pois tem as variaveis internas dele.
  late final TextEditingController _nameEC;
  late final TextEditingController _emailEC;

  //Uma vez iniciado novos objetos de classes, estas precisam ser finalizadas apos mudança de tela, para isto "Dispose"
  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //para receber os atributos, estas devem ser widgets
    _nameEC = TextEditingController(text: widget.contato.name);
    _emailEC = TextEditingController(text: widget.contato.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: BlocListener<ContactUpdateBloc, ContactUpdateState>(
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
            success: () => Navigator.of(context).pop(),
          );
        },
        child: Padding(
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
                      context.read<ContactUpdateBloc>().add(
                            ContactUpdateEvent.save(
                              id: widget.contato.id!,
                              email: _emailEC.text,
                              name: _nameEC.text,
                            ),
                          );
                    }
                  },
                  child: const Text("Salvar"),
                ),
                Loader<ContactUpdateBloc, ContactUpdateState>(
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
        ),
      ),
    );
  }
}
