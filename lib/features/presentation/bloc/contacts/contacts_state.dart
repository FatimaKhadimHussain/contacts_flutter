part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<Contact> contacts;

  const ContactsLoaded({
    required this.contacts,
  });

  @override
  List<Object> get props => [contacts];
}

class FavoriteContactsLoaded extends ContactsState {
  final List<Contact> favoriteContacts;

  const FavoriteContactsLoaded({
    required this.favoriteContacts,
  });

  @override
  List<Object> get props => [favoriteContacts];
}

// class ShowContacts extends ContactsState {}

class ContactAdded extends ContactsState {}

class ContactUpdated extends ContactsState {}

class ContactDeleted extends ContactsState {}

class ContactsFailure extends ContactsState {
  final String message;

  const ContactsFailure({
    required this.message,
  });
}