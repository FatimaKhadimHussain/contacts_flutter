import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  int? id;
  String name;
  String? mobile;
  String? landline;
  Uint8List? photo;
  bool favorite = false;

  Contact({this.id, this.name = '', this.mobile, this.landline, this.photo,
      this.favorite = false});

  @override
  List<Object?> get props => [id, name, mobile, landline, photo];
}
