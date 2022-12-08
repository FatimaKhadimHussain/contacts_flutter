import 'package:contacts_flutter/features/data/data_sources/contacts/contact_datasource.dart';
import 'package:contacts_flutter/features/data/repositories/contacts/contact_repository_impl.dart';
import 'package:contacts_flutter/features/domain/repositories/contacts/contact_repository.dart';
import 'package:contacts_flutter/features/domain/use_cases/contacts/add_contact.dart';
import 'package:contacts_flutter/features/domain/use_cases/contacts/delete_contact.dart';
import 'package:contacts_flutter/features/domain/use_cases/contacts/get_all_contacts.dart';
import 'package:contacts_flutter/features/domain/use_cases/contacts/update_contact.dart';
import 'package:contacts_flutter/features/presentation/bloc/contacts/contacts_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/domain/use_cases/contacts/get_favorite_contacts.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {

  //bloc
  sl.registerFactory(() => ContactsBloc(addContact: sl(), deleteContact: sl(), updateContact: sl(), getAllContacts: sl(), getFavoriteContacts: sl()));

  //use-cases
  sl.registerLazySingleton(() => AddContact(repository: sl()));
  sl.registerLazySingleton(() => UpdateContact(repository: sl()));
  sl.registerLazySingleton(() => DeleteContact(repository: sl()));
  sl.registerLazySingleton(() => GetAllContacts(repository: sl()));
  sl.registerLazySingleton(() => GetFavoriteContacts(repository: sl()));

  //repository
  sl.registerLazySingleton<ContactRepository>(() => ContactRepositoryImpl(contactDatasource: sl()));

  //datasource
  sl.registerLazySingleton<ContactDatasource>(() => ContactDatasourceImpl());

  //core

  //external

}