import 'package:contacts_flutter/features/presentation/pages/contacts/add_update_contact_screen.dart';
import 'package:flutter/material.dart';

import '../../pages/contacts/favorite_contacts_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Contacts', style: TextStyle(color: Colors.white),),
        ),

        // contacts
        ListTile(
          title: const Text('Contact list'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        // favorite contacts
        ListTile(
          title: const Text('Favorite contacts'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, FavoriteContactsScreen.id);
          },
        ),
        // add contact
        ListTile(
          title: const Text('Add new contact'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AddContactScreen.id);
          },
        ),
      ],
    ));
  }
}
