import 'package:contacts_flutter/features/presentation/widgets/contacts/contact_list.dart';
import 'package:contacts_flutter/features/presentation/widgets/contacts/add_contact_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/contacts/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Contact List'),
      ),
      body: const ContactList(),
      drawer: const AppDrawer(),
      floatingActionButton: const AddContactButton(),
    );
  }
}
