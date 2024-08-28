import 'package:contact/contacts/modal/contacts_modal.dart';
import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactInitial extends ContactState {
  const ContactInitial();

  @override
  List<Object> get props => [];
}

class ContactLoading extends ContactState {
  const ContactLoading();

  @override
  List<Object> get props => [];
}

class ContactLoaded extends ContactState {
  const ContactLoaded(this.contactsList, this.page);
  final ContactsModal contactsList;
  final int page;

  @override
  List<Object> get props => [contactsList, page];
}

class ContactError extends ContactState {
  const ContactError(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
