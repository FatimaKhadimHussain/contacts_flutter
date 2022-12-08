
import 'package:contacts_flutter/core/error/failures.dart';
import 'package:contacts_flutter/features/domain/entities/contacts/contact_item.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<Contact>>>loadAllContacts();
  Future<Either<Failure, List<Contact>>>loadFavoriteContacts();
  Future<Either<Failure, int>>addContact({required Contact contact});
  Future<Either<Failure, int>>updateContact({required Contact contact});
  Future<Either<Failure, int>>deleteContact({required Contact contact});
}