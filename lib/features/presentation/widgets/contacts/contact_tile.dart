import 'package:contacts_flutter/core/params/contact_screen_params.dart';
import 'package:contacts_flutter/features/presentation/pages/contacts/add_update_contact_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/enums.dart';
import '../../../domain/entities/contacts/contact_item.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final ContactListType listType;

  const ContactTile({super.key, required this.contact, required this.listType});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name),
      subtitle: Text(contact.mobile ?? ''),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 35,
          height: 35,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            minRadius: 25.0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 23.0,
              backgroundImage: (contact.photo == null) ? null : MemoryImage(contact.photo!),
              child: contact.photo == null
                  ? const Icon(
                      Icons.person,
                      size: 20.0,
                    )
                  : null,
            ),
          ),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: listType == ContactListType.favorite
            ? null
            : Icon(Icons.star,
                color: contact.favorite ? Colors.red : Colors.white),
      ),
      onTap: () {
        Navigator.pushNamed(context, AddContactScreen.id,
            arguments: ContactScreenArguments(
                contact: contact, mode: ContactScreenMode.update));
      },
    );
  }
}
