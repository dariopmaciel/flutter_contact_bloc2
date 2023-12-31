import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:flutter_contact_bloc/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_list_cubit_state.dart';
part 'contact_list_cubit.freezed.dart';

class ContactListCubit extends Cubit<ContactListCubitState> {
  final ContactsRepository _repository;
  ContactListCubit({required ContactsRepository repository})
      : _repository = repository,
        super(ContactListCubitState.initial());

//no CUBIT não tem EVENTO 'on<_ContactListEventFindAll>(_findAll);' basta fazer o mateio de evento para função

  Future<void> findAll() async {
    try {
      emit(ContactListCubitState.loading());
      final contacts = await _repository.findAll();
      await Future.delayed(const Duration(seconds: 2));
      emit(ContactListCubitState.data(contacts: contacts));
    } catch (e, s) {
      log("Erro ao buscar contatos", error: e, stackTrace: s);
      emit(ContactListCubitState.error(error: "Erro ao buscar contatos"));
    }
  }

  Future<void> deleteByModel(ContactModel model) async {
    emit(ContactListCubitState.loading());
    final delete = await _repository.delete(model);
    findAll();
  }

  Future<void> createContact(ContactModel newContact) async {
    try {
      emit(ContactListCubitState.loading());
      await _repository.create(
          newContact); // Suponha que haja um método `create` no seu repositório
      final contacts = await _repository.findAll();
      emit(ContactListCubitState.data(contacts: contacts));
    } catch (e, s) {
      log("Erro ao criar contato", error: e, stackTrace: s);
      emit(ContactListCubitState.error(error: "Erro ao criar contato"));
    }
  }

  // Future<void> _updateContact(
  //     _UpdateContact event, Emitter<ContactListState> emit) async {
  //   try {
  //     emit(ContactListState.loading());
  //     await _repository.update(event.updatedContact);
  //     final contacts = await _repository.findAll();
  //     emit(ContactListState.data(contacts: contacts));
  //   } catch (e, s) {
  //     log("Erro ao atualizar contato", error: e, stackTrace: s);
  //     emit(ContactListState.error(error: "Erro ao Atualizar o Contato"));
  //   }
  // }
}
