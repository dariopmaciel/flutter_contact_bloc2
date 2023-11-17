import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:flutter_contact_bloc/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_event.dart';
part 'contact_update_state.dart';
part 'contact_update_bloc.freezed.dart';

class ContactUpdateBloc extends Bloc<ContactUpdateEvent, ContactUpdateState> {
  final ContactsRepository _contactRepository;

  ContactUpdateBloc({required ContactsRepository contactRepository})
      : _contactRepository = contactRepository,
        super(const _Initial()) {
    on<_Save>(_save);
  }

  Future<FutureOr<void>> _save(
      _Save event, Emitter<ContactUpdateState> emit) async {
    try {
      emit(const ContactUpdateState.loading());
      final model = ContactModel(
        id: event.id,
        name: event.name,
        email: event.email,
      );
      await _contactRepository.update(model);
      emit(const ContactUpdateState.success());
    } catch (e, s) {
      log("Erro ao atualizar o contato", error: e, stackTrace: s);
      emit(
          const ContactUpdateState.errod(message: 'Erro au atualizar contato'));
    }
  }
}
