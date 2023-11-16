import 'dart:async';
import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/foundation.dart';

import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:flutter_contact_bloc/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_register_state.dart';
part 'contact_register_event.dart';
part 'contact_register_bloc.freezed.dart';

class ContactRegisterBloc
    extends Bloc<ContactRegisterEvent, ContactRegisterState> {
  // instanciado 'ContactsRepository _repository;' apara poder ligar o repositorio ao cadastro
  final ContactsRepository _contactRepository;

  ContactRegisterBloc({required ContactsRepository contactRepository})
      : _contactRepository = contactRepository,
        super(const ContactRegisterState.initial()) {
    on<_Save>(_save);
  }

  FutureOr<void> _save(_Save event, Emitter<ContactRegisterState> emit) async {
    try {
      emit(const ContactRegisterState.loading());

      await Future.delayed(const Duration(seconds: 1));

      final contactModel = ContactModel(
        name: event.name,
        email: event.email,
      );

      await _contactRepository.create(contactModel);
      emit(const ContactRegisterState.success());
    } catch (e, s) {
      log('Erro ao salvar novo usuário', error: e, stackTrace: s);
      emit(const ContactRegisterState.error(
          message: "Erro ao salvar um novo contato"));
    }
  }
}
