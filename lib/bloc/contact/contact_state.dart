part of 'contact_bloc.dart';

sealed class ContactState {}

final class ContactInitial extends ContactState {}

final class ContactLoading extends ContactState {}

final class ContactSuccess extends ContactState {}

final class ContactFailure extends ContactState {
  final String err;

  ContactFailure({required this.err});
}
