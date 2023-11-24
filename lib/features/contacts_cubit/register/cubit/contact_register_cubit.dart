import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_bloc/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_cubit_state.dart';
part 'contact_register_cubit.freezed.dart';

class ContactRegisterCubit extends Cubit {
  final ContactsRepository _repository;
  ContactRegisterCubit({required ContactsRepository repository})
      : _repository = repository,
        super(ContactRegisterCubitState.initial());
}
