import 'package:contacts_flutter/core/error/failures.dart';
import 'package:contacts_flutter/core/usecases/usecase.dart';
import 'package:contacts_flutter/features/domain/entities/contacts/contact_item.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/contacts/contact_repository.dart';

class GetAllContacts implements Usecase<List<Contact>, NoParams>{
  final ContactRepository repository;

  const GetAllContacts({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Contact>>> call(NoParams params) async {
    return await repository.loadAllContacts();
  }
}