import 'package:contacts_flutter/core/params/contact_screen_params.dart';
import 'package:contacts_flutter/features/presentation/pages/contacts/add_update_contact_screen.dart';
import 'package:contacts_flutter/features/presentation/pages/contacts/home_screen.dart';
import 'package:flutter/material.dart';

import '../../features/presentation/pages/contacts/favorite_contacts_screen.dart';

class AppRouter {
  MaterialPageRoute? onGenerateRoutes(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(builder: (builder) => const HomeScreen(),);
      case AddContactScreen.id:
        //return MaterialPageRoute(builder: (builder) => AddContactScreen(),);
        final args = routeSettings.arguments as ContactScreenArguments;

        // Then, extract the required data from
        // the arguments and pass the data to the
        // correct screen.
        return MaterialPageRoute(
          builder: (context) {
            return AddContactScreen(
              contact: args.contact,
              mode: args.mode,
            );
          },
        );
      case FavoriteContactsScreen.id:
        return MaterialPageRoute(builder: (builder) => const FavoriteContactsScreen(),);
      default:
        return null;
    }
  }
}