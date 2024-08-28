// To parse this JSON data, do
//
//     final contactsModal = contactsModalFromJson(jsonString);

import 'dart:convert';

ContactsModal contactsModalFromJson(String str) =>
    ContactsModal.fromJson(json.decode(str));

class ContactsModal {
  List<Result> results;
  Info info;

  ContactsModal({
    required this.results,
    required this.info,
  });

  factory ContactsModal.fromJson(Map<String, dynamic> json) => ContactsModal(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        info: Info.fromJson(json["info"]),
      );
}

class Info {
  String seed;
  int results;
  int page;
  String version;

  Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        seed: json["seed"],
        results: json["results"],
        page: json["page"],
        version: json["version"],
      );
}

class Result {
  Name name;
  String phone;
  String cell;
  Picture picture;

  Result({
    required this.name,
    required this.phone,
    required this.cell,
    required this.picture,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: Name.fromJson(json["name"]),
        phone: json["phone"],
        cell: json["cell"],
        picture: Picture.fromJson(json["picture"]),
      );
}

class Name {
  String title;
  String first;
  String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        title: json["title"],
        first: json["first"],
        last: json["last"],
      );
}

class Picture {
  String large;
  String medium;
  String thumbnail;

  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        large: json["large"],
        medium: json["medium"],
        thumbnail: json["thumbnail"],
      );
}
