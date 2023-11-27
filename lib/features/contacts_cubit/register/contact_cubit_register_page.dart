import 'package:flutter/material.dart';

class ContactCubitRegisterPage extends StatefulWidget {
  const ContactCubitRegisterPage({super.key});

  @override
  State<ContactCubitRegisterPage> createState() =>
      _ContactCubitRegisterPageState();
}

class _ContactCubitRegisterPageState extends State<ContactCubitRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeEC = TextEditingController();
  final _emailEC = TextEditingController();

  @override
  void dispose() {
    _nomeEC.dispose();
    _emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register Cubit')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeEC,
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
                  controller: _emailEC,
                  keyboardType: TextInputType.emailAddress,
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
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () {
                    // final validade = _formKey.currentState?.validate() ?? false;
                    // if (validade) {
                    //   context.read<ContactRegisterBloc>().add(
                    //         ContactRegisterEvent.save(
                    //           name: _nomeEC.text,
                    //           email: _emailEC.text,
                    //         ),
                    //       );
                    // }
                  },
                  child: const Text("SALVAR"),
                ),
              ],
            ),
          ),
        ));
  }
}
