import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/enums.dart';
import '../../bloc/contacts/contacts_bloc.dart';
import '../../widgets/contacts/contact_tile.dart';
import '../../widgets/contacts/empty_contacts.dart';
import '../../widgets/contacts/loading_indicator.dart';

const kNoFavoriteContact = 'No favorite contacts';

class FavoriteContactsScreen extends StatefulWidget {
  static const id = 'FavoriteContactsScreen';

  const FavoriteContactsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteContactsScreen> createState() => _FavoriteContactsScreenState();
}

class _FavoriteContactsScreenState extends State<FavoriteContactsScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ContactsBloc>().add(GetFavoriteContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //context.read<ContactsBloc>().add(GetAllContactsEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Contact List'),
        ),
        body: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const LoadingIndicator();
            } else if (state is FavoriteContactsLoaded) {
              if (state.favoriteContacts.isEmpty) {
                return const EmptyContacts(message: kNoFavoriteContact);
              } else {
                return ListView.builder(
                  itemCount: state.favoriteContacts.length,
                  itemBuilder: (context, index) {
                    return ContactTile(contact: state.favoriteContacts[index], listType: ContactListType.favorite);
                  },
                );
              }
            }
            return const EmptyContacts(message: kNoFavoriteContact);
          },
        ),
      ),
    );
  }
}
