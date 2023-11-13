import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_contact_bloc/repositories/contacts_repository.dart';

part 'contact_list_bloc.freezed.dart';
part 'contact_list_event.dart';
part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactsRepository _repository;

  ContactListBloc({required ContactsRepository repository})
      : _repository = repository,
        super(ContactListState.initial()) {
    on<_ContactListEventFindAll>(_findAll);
  }

  Future<void> _findAll(
      _ContactListEventFindAll event, Emitter<ContactListState> emit) async {
    final contacts = await _repository.finalAll();
    emit(ContactListState.data(contacts: contacts));
  }
}
