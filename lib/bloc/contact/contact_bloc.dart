import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thebasiclook/services/contact.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<ContactSubmitEvent>(contactSubmitEvent);
  }

  FutureOr<void> contactSubmitEvent(
      ContactSubmitEvent event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    try {
      final response = await Contact().contact(
        email: event.email,
        name: event.name,
        phone: event.phone,
        message: event.message,
      );
      if (response.statusCode == 200) {
        print('message sent now ');
        emit(ContactSuccess());
      } else {
        final errorMessage = response.body;
        emit(ContactFailure(err: errorMessage));
      }
    } catch (e) {
      emit(ContactFailure(err: e.toString()));
    }
  }
}
