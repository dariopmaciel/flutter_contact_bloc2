import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_event.dart';
part 'contact_update_state.dart';
part 'contact_update_bloc.freezed.dart';

class ContactUpdateBloc extends Bloc<ContactUpdateEvent, ContactUpdateState> {
  ContactUpdateBloc() : super(_Initial()) {
    on<ContactUpdateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
