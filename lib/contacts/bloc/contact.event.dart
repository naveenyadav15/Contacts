abstract class ContactEvent {
  const ContactEvent();
}

class GetContacts extends ContactEvent {
  const GetContacts(this.page);
  final int page;
}
