import 'package:contact/contacts/bloc/contact.event.dart';
import 'package:contact/contacts/bloc/contact.state.dart';
import 'package:contact/contacts/bloc/contacts.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactsBloc()..add(const GetContacts(0)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contacts"),
        ),
        body: BlocBuilder<ContactsBloc, ContactState>(
          builder: (context, state) {
            if (state is ContactLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ContactLoaded) {
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      state is! ContactLoading) {
                    context
                        .read<ContactsBloc>()
                        .add(GetContacts(state.page + 1));
                  }
                  return false;
                },
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: state.contactsList.results.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.contactsList.results.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final contact = state.contactsList.results[index];
                      return ListTile(
                        title:
                            Text("${contact.name.first} ${contact.name.last}"),
                        subtitle: Text(contact.phone),
                        trailing: Text("${index}"),
                      );
                    },
                  ),
                ),
              );
            } else if (state is ContactError) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return const Center(
                child: Text('No Contacts Available'),
              );
            }
          },
        ),
      ),
    );
  }
}
