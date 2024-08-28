import 'package:contact/contacts/bloc/contact.event.dart';
import 'package:contact/contacts/bloc/contact.state.dart';
import 'package:contact/contacts/modal/contacts_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ContactsBloc extends Bloc<ContactEvent, ContactState> {
  ContactsBloc() : super(const ContactInitial()) {
    on<GetContacts>(_fetchContacts);
  }

  void _fetchContacts(GetContacts event, Emitter<ContactState> emit) async {
    final currentState = state;

    try {
      if (currentState is ContactLoaded) {
        final nextPage = currentState.page + 1;
        final newContacts = await callAPI(nextPage);
        final allContacts = currentState.contactsList;
        allContacts.results.addAll(newContacts.results);

        emit(ContactLoaded(allContacts, nextPage));
      } else {
        emit(const ContactLoading());
        final contactsList = await callAPI(event.page);
        emit(ContactLoaded(contactsList, event.page));
      }
    } catch (e) {
      if (currentState is ContactLoaded) {
        emit(ContactLoaded(currentState.contactsList, currentState.page));
      } else {
        emit(ContactError('Failed to load contacts: $e'));
      }
    }
  }

  Future<ContactsModal> callAPI(int page) async {
    var url = Uri.https(
      'randomuser.me',
      '/api/',
      {
        "page": page.toString(),
        "results": "10",
        "seed": "abc",
      },
    );

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return contactsModalFromJson(response.body);
    } else {
      throw Exception('Failed to fetch the data: ${response.statusCode}.');
    }
  }
}
