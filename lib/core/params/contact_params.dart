import 'package:equatable/equatable.dart';

import '../../features/domain/entities/contacts/contact_item.dart';

class ContactParams extends Equatable {
  final Contact contactItem;

  const ContactParams({
    required this.contactItem,
  });

  @override
  List<Object?> get props => [contactItem];
}