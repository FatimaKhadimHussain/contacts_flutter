import 'package:contacts_flutter/features/data/models/contacts/contact_model.dart';

import '../../../../core/data/database_helper.dart';

abstract class ContactDatasource {
  Future<List<ContactModel>> getAllContacts();
  Future<List<ContactModel>> getFavoriteContacts();
  Future<int> addContact(ContactModel contactModel);
  Future<int> deleteContact(ContactModel contactModel);
  Future<int> updateContact(ContactModel contactModel);
}

class ContactDatasourceImpl implements ContactDatasource {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<int> addContact(ContactModel contactModel) async {
    return await _databaseHelper.addContact(contactModel);
  }

  @override
  Future<int> deleteContact(ContactModel contactModel) async {
    return await _databaseHelper.deleteContact(contactModel.id ?? -1);
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    return await _databaseHelper.getAllContacts(columns: [
      ContactModel.columnId,
      ContactModel.columnName,
      ContactModel.columnMobile,
      ContactModel.columnLandline,
      ContactModel.columnPhoto,
      ContactModel.columnFavorite
    ], columnName: ContactModel.columnName, order: 'ASC');
  }

  @override
  Future<int> updateContact(ContactModel contactModel) async {
   return await _databaseHelper.updateContact(contactModel);
  }

  @override
  Future<List<ContactModel>> getFavoriteContacts() async {
    return await _databaseHelper.getFavoriteContacts(columns: [
      ContactModel.columnId,
      ContactModel.columnName,
      ContactModel.columnMobile,
      ContactModel.columnLandline,
      ContactModel.columnPhoto,
      ContactModel.columnFavorite
    ], columnName: ContactModel.columnName, order: 'ASC');
  }
}
