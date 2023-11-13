import 'package:dio/dio.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';

class ContactsRepository {
  //FindAll
  Future<List<ContactModel>> finalAll() async {
    final response = await Dio().get('http://10.0.0.100:3031/contacts');

    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

//Create
  Future<void> create(ContactModel model) async =>
      Dio().post("http://10.0.0.100:3031/contacts", data: model.toMap());

  //OU ASSIM!!!!
  //  Future<void> create(ContactModel model) async {
  //   Dio().post("http://localhost/contacts", data: model.toMap());
  // }

  Future<void> update(ContactModel model) =>
      Dio().put("http://10.0.0.100:3031/contacts/${model.id}", data: model.toMap());
}

Future<void> delete(ContactModel model) =>
    Dio().delete("http://10.0.0.100:3031/contacts/${model.id}");
