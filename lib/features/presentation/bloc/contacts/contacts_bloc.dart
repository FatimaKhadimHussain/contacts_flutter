
import 'package:bloc/bloc.dart';
import 'package:contacts_flutter/core/params/contact_params.dart';
import 'package:contacts_flutter/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/contacts/contact_item.dart';
import '../../../domain/use_cases/contacts/add_contact.dart';
import '../../../domain/use_cases/contacts/delete_contact.dart';
import '../../../domain/use_cases/contacts/get_all_contacts.dart';
import '../../../domain/use_cases/contacts/get_favorite_contacts.dart';
import '../../../domain/use_cases/contacts/update_contact.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final AddContact addContact;
  final DeleteContact deleteContact;
  final UpdateContact updateContact;
  final GetAllContacts getAllContacts;
  final GetFavoriteContacts getFavoriteContacts; 

  ContactsBloc({
    required this.addContact,
    required this.deleteContact,
    required this.updateContact,
    required this.getAllContacts,
    required this.getFavoriteContacts
  }) : super(ContactsInitial()) {
    on<AddContactEvent>((event, emit) async {
      _onAddContact(event, emit);
    });
    on<UpdateContactEvent>((event, emit) {
      _onUpdateContact(event, emit);
    });
    on<DeleteContactEvent>((event, emit) {
      _onDeleteContact(event, emit);
    });
    on<GetAllContactsEvent>((event, emit) {
      _onGetAllContacts(event, emit);
    });
    on<GetFavoriteContactsEvent>((event, emit){
      _onGetFavoriteContacts(event, emit);
    });
  }

  Future<void> _onAddContact(
      AddContactEvent event, Emitter<ContactsState> state) async {
    emit(ContactsLoading());
    final eitherResultOrFailure =
    await addContact(ContactParams(contactItem: event.contact));
    eitherResultOrFailure.fold((left) {
      emit(const ContactsFailure(message: "Contact didn't added"));
    }, (right) {
      emit(ContactAdded());
    });
  }

  Future<void> _onUpdateContact(
      UpdateContactEvent event, Emitter<ContactsState> state) async {
    emit(ContactsLoading());
    final eitherResultOrFailure =
    await updateContact(ContactParams(contactItem: event.contact));
    eitherResultOrFailure.fold((left) {
      emit(const ContactsFailure(message: "Contact didn't updated"));
    }, (right) {
      emit(ContactUpdated());
    });
  }

  Future<void> _onDeleteContact(
      DeleteContactEvent event, Emitter<ContactsState> state) async {
    emit(ContactsLoading());
    final eitherResultOrFailure =
    await deleteContact(ContactParams(contactItem: event.contact));
    eitherResultOrFailure.fold((left) {
      emit(const ContactsFailure(message: "Contact didn't deleted"));
    }, (right) {
      emit(ContactDeleted());
    });
  }

  Future<void> _onGetAllContacts(
      GetAllContactsEvent event, Emitter<ContactsState> state) async {
    emit(ContactsLoading());
    final eitherResultOrFailure =
    await getAllContacts(NoParams());
    eitherResultOrFailure.fold((left) {
      emit(const ContactsFailure(message: "Contacts didn't loaded"));
    }, (contacts) {
      emit(ContactsLoaded(contacts: contacts));
    });
  }

  Future<void> _onGetFavoriteContacts(
      GetFavoriteContactsEvent event, Emitter<ContactsState> state) async {
    emit(ContactsLoading());
    final eitherResultOrFailure =
    await getFavoriteContacts(NoParams());
    eitherResultOrFailure.fold((left) {
      emit(const ContactsFailure(message: "Favorite Contacts didn't loaded"));
    }, (contacts) {
      emit(FavoriteContactsLoaded(favoriteContacts: contacts));
    });
  }
}
