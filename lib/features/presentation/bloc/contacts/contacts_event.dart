part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

class AddContactEvent extends ContactsEvent {
  final Contact contact;

  const AddContactEvent({
    required this.contact,
  });

  @override
  List<Object?> get props => [contact];
}

class UpdateContactEvent extends ContactsEvent {
  final Contact contact;

  const UpdateContactEvent({
    required this.contact,
  });

  @override
  List<Object?> get props => [contact];
}

class DeleteContactEvent extends ContactsEvent {
  final Contact contact;

  const DeleteContactEvent({
    required this.contact,
  });

  @override
  List<Object?> get props => [contact];
}

class GetAllContactsEvent extends ContactsEvent {}

class GetFavoriteContactsEvent extends ContactsEvent {}