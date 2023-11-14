import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_state.dart';
part 'contact_register_event.dart';


class ContactRegisterBloc extends Bloc<ContactRegisterEvent, ContactRegisterState>{
  ContactRegisterBloc():super(const ContactRegisterState.initial());
   
}