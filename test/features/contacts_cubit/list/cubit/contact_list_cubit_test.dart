import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_contact_bloc/features/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:flutter_contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
    //declaração
  late MockContactsRepository repository;
  late ContactListCubit cubit;
  late List<ContactModel> contacts;

//preparação
  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactListCubit(repository: repository);
    contacts = [
      ContactModel(name: "A1", email: 'a1@hotmail.com'),
      ContactModel(name: "A2", email: 'a2@hotmail.com'),
      ContactModel(name: "A3", email: 'a3@hotmail.com'),
    ];
  });

  //execução
  blocTest<ContactListCubit, ContactListCubitState>(
    'Deve buscar os contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((_) async => contacts);
    },
    expect: () => [
      ContactListCubitState.loading(),
      ContactListCubitState.data(contacts: contacts),
    ],
  );
}
