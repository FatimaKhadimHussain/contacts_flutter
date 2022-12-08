import 'package:contacts_flutter/core/enums/enums.dart';
import 'package:contacts_flutter/features/presentation/widgets/contacts/contact_tile.dart';
import 'package:contacts_flutter/features/presentation/widgets/contacts/empty_contacts.dart';
import 'package:flutter/material.dart';
import '../../../../core/router/route_aware_state.dart';
import '../../bloc/contacts/contacts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_indicator.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends RouteAwareState<ContactList> {
  @override
  void onEnterScreen() {
    print('onEnterScreen');
    context.read<ContactsBloc>().add(GetAllContactsEvent());
  }

  @override
  void onLeaveScreen() {
    print('onLeaveScreen');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactsBloc, ContactsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoaded) {
              if (state.contacts.isEmpty) {
                return const EmptyContacts(
                  message: "No contacts are available, "
                      "Let's add contact by clicking on + button",
                );
              } else {
                return ListView.builder(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      return ContactTile(
                        contact: state.contacts[index],
                        listType: ContactListType.all,
                      );
                    });
              }
            } else if (state is ContactsFailure) {
              return const Center(
                child: EmptyContacts(
                  message: "No contacts are available, "
                      "Let's add contact by clicking on + buttom",
                ),
              );
            }
            return const LoadingIndicator();
          },
        );
      },
    );
  }
}
