import 'package:contacts_flutter/features/presentation/bloc/contacts/contacts_bloc.dart';
import 'package:contacts_flutter/features/presentation/widgets/contacts/add_update_contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../domain/entities/contacts/contact_item.dart';

class AddContactScreen extends StatefulWidget {
  static const id = 'AddContactScreen';

  final Contact contact;
  final ContactScreenMode mode;

  const AddContactScreen({
    super.key,
    required this.contact,
    required this.mode,
  });

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {

  @override
  Widget build(BuildContext context) {

    final screenTitle = widget.mode == ContactScreenMode.add
        ? 'Add New Contact'
        : 'Update Contact';

    void showMessage(String message) async {
      await DialogUtils.displayDialogOKCallBack(context, message, '').then(
            (value) {
          if (value == true) {
            Navigator.pop(context);
          }
        },
      );
    }

    void onDeleteTapAction() async {
      await DialogUtils.displayConfirmationDialogCallBack(context, 'Confirmation', 'Do you want to delete the contact?').then(
            (value) {
          if (value == 'ok') {
            context
                .read<ContactsBloc>()
                .add(DeleteContactEvent(contact: widget.contact));
          }
        },
      );
    }

    List<Widget> topBarActions() {
      final deleteAction = Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {
            onDeleteTapAction();
          },
          child: const Icon(
            Icons.delete,
            size: 26.0,
          ),
        ),
      );

      final favoriteAction = Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.contact.favorite = !widget.contact.favorite;
            });
          },
          child: Icon(Icons.star,
              color: widget.contact.favorite ? Colors.red : Colors.black),
        ),
      );
      return widget.mode == ContactScreenMode.add
          ? [favoriteAction]
          : [favoriteAction, deleteAction];
    }

    return BlocListener<ContactsBloc, ContactsState>(
      listener: (context, state) {
        if (state is ContactAdded || state is ContactUpdated) {
          showMessage(widget.mode == ContactScreenMode.add
              ? 'Contact added successfully'
              : 'Contact updated successfully');
        } else if (state is ContactDeleted) {
          showMessage('Contact deleted successfully');
        } else if (state is ContactsFailure) {
          showMessage(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          actions: topBarActions(),
        ),
        body: AddUpdateContactForm(contact: widget.contact, mode: widget.mode),
      ),
    );
  }
}
