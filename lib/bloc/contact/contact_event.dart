part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class ContactSubmitEvent extends ContactEvent {
  final String email;
  
   final String name;
  
   final String phone;
  
   final String message;
  

  ContactSubmitEvent(
      {required this.email,
      required  this.name,
      required  this.phone,
      required  this.message,
      });
}
