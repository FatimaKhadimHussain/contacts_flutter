import 'dart:typed_data';

import 'package:contacts_flutter/features/domain/entities/contacts/contact_item.dart';

class ContactModel extends Contact {
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnMobile = 'mobile';
  static const String columnLandline = 'landline';
  static const String columnPhoto = 'photo';
  static const String columnFavorite = 'favorite';

  ContactModel(
      {super.id,
      required super.name,
      super.mobile,
      super.landline,
      super.photo,
      super.favorite});

  ContactModel copyWith({
    int? id,
    String? name,
    String? mobile,
    String? landline,
    Uint8List? photo
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      landline: landline ?? this.landline,
      photo: photo ?? this.photo
    );
  }

  factory ContactModel.fromDatabaseJson(Map<String, dynamic> json) {
    return ContactModel(
        id: json['id'] ?? 0,
        name: json['name'],
        mobile: json['mobile'],
        landline: json['landline'],
        photo: json['photo'],
        favorite: json['favorite'] == 0 ? false : true
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'landline': landline,
      'photo': photo,
      'favorite': favorite == false ? 0 : 1
    };
  }

  factory ContactModel.fromContact(Contact contact) {
    return ContactModel(
        id: contact.id,
        name: contact.name,
        mobile: contact.mobile,
        landline: contact.landline,
        photo: contact.photo,
        favorite: contact.favorite
    );
  }
}
