
import '../../features/domain/entities/contacts/contact_item.dart';
import '../enums/enums.dart';


class ContactScreenArguments {
  final Contact contact;
  final ContactScreenMode mode;

  ContactScreenArguments({required this.contact, required this.mode});
}