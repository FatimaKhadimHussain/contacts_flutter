import 'package:contacts_flutter/core/params/contact_screen_params.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/enums.dart';
import '../../../domain/entities/contacts/contact_item.dart';
import '../../pages/contacts/add_update_contact_screen.dart';

class AddContactButton extends StatelessWidget {
  const AddContactButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AddContactScreen.id, arguments: ContactScreenArguments(contact: Contact(), mode: ContactScreenMode.add));
      },
      child: const Icon(Icons.add),
    );
  }
}
