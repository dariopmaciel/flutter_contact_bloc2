import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:flutter_contact_bloc/models/contact_model.dart';
import 'package:flutter_contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
//declaração
  late MockContactsRepository repository;
  late ContactListBloc bloc;
  late List<ContactModel> contacts;

//preparação
  setUp(() {
    repository = MockContactsRepository();
    bloc = ContactListBloc(repository: repository);
    contacts = [
      ContactModel(name: "A1", email: 'a1@hotmail.com'),
      ContactModel(name: "A2", email: 'a2@hotmail.com'),
      ContactModel(name: "A3", email: 'a3@hotmail.com'),
    ];
  });

//execução
  blocTest<ContactListBloc, ContactListState>(
    'Deve buscar os contatos:',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactListEvent.findAll()),
    expect: () => [
      ContactListState.loading(),
      ContactListState.data(contacts: contacts),
    ],
  );
}
