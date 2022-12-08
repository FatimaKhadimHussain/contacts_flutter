import 'package:contacts_flutter/core/error/failures.dart';
import 'package:contacts_flutter/features/data/data_sources/contacts/contact_datasource.dart';
import 'package:contacts_flutter/features/data/models/contacts/contact_model.dart';
import 'package:contacts_flutter/features/domain/entities/contacts/contact_item.dart';
import 'package:contacts_flutter/features/domain/repositories/contacts/contact_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDatasource contactDatasource;

  const ContactRepositoryImpl({
    required this.contactDatasource,
  });

  @override
  Future<Either<Failure, int>> addContact({required Contact contact}) async {
    try {
      final result =
          await contactDatasource.addContact(ContactModel.fromContact(contact));
      if (result == 0) {
        return Left(DatabseFailure());
      }
        return Right(result);
    } catch (error) {
      if (kDebugMode) {
        print('addContact error:$error');
      }
      return Left(DatabseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteContact({required Contact contact}) async {
    try {
      final result =
          await contactDatasource.deleteContact(ContactModel.fromContact(contact));
      if (result == 0) {
        return Left(DatabseFailure());
      }
      return Right(result);
    } catch (error) {
      if (kDebugMode) {
        print('deleteContact error:$error');
      }
      return Left(DatabseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> loadAllContacts() async {
    try {
      final result =
      await contactDatasource.getAllContacts();
      return Right(result);
    } catch (error) {
      if (kDebugMode) {
        print('load contacts error:$error');
      }
      return Left(DatabseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> updateContact({required Contact contact}) async {
    try {
      final result =
      await contactDatasource.updateContact(ContactModel.fromContact(contact));
      if (result == 0) {
        return Left(DatabseFailure());
      }
      return Right(result);
    } catch (error) {
      if (kDebugMode) {
        print('updateContact error:$error');
      }
      return Left(DatabseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> loadFavoriteContacts() async {
    try {
      final result =
          await contactDatasource.getFavoriteContacts();
      return Right(result);
    } catch (error) {
      if (kDebugMode) {
        print('load favorite contacts error:$error');
      }
      return Left(DatabseFailure());
    }
  }
}
