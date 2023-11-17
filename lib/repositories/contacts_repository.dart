// import 'package:dio/dio.dart';
// import 'package:flutter_contact_bloc/models/contact_model.dart';

// class ContactsRepository {
//   Future<List<ContactModel>> finalAll() async {
//     final response = await Dio().get('http://10.0.0.100:3031/contacts');

//     return response.data
//         ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
//         .toList();
//   }

//   Future<void> create(ContactModel model) async =>
//       Dio().post("http://10.0.0.100:3031/contacts", data: model.toMap());

//   Future<void> update(ContactModel model) => Dio()
//       .put("http://10.0.0.100:3031/contacts/${model.id}", data: model.toMap());

//   Future<void> delete(ContactModel model) =>
//       Dio().delete("http://10.0.0.100:3031/contacts/${model.id}");
// }

import 'package:dio/dio.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';

class ContactsRepository {
  // Criando uma instância única de Dio para reutilização
  final Dio _dio = Dio();

  Future<List<ContactModel>> findAll() async {
    try {
      final response = await _dio.get('http://10.0.0.100:3031/contacts');

      return response.data
              ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
              .toList() ??
          [];
    } catch (e) {
      // Tratamento de erro, por exemplo, lançar ou logar a exceção
      print('Erro ao buscar contatos: $e');
      throw Exception('Erro ao buscar contatos');
    }
  }

  Future<void> create(ContactModel model) async {
    try {
      await _dio.post("http://10.0.0.100:3031/contacts", data: model.toMap());
    } catch (e) {
      print('Erro ao criar contato: $e');
      throw Exception('Erro ao criar contato');
    }
  }

  Future<void> update(ContactModel model) async {
    try {
      await _dio.put("http://10.0.0.100:3031/contacts/${model.id}",
          data: model.toMap());
    } catch (e) {
      print('Erro ao atualizar contato: $e');
      throw Exception('Erro ao atualizar contato');
    }
  }

  Future<void> delete(ContactModel model) async {
    try {
      await _dio.delete("http://10.0.0.100:3031/contacts/${model.id}");
    } catch (e) {
      print('Erro ao excluir contato: $e');
      throw Exception('Erro ao excluir contato');
    }
  }
}
