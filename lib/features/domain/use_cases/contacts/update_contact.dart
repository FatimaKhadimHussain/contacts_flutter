import 'package:contacts_flutter/core/error/failures.dart';
import 'package:contacts_flutter/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/params/contact_params.dart';
import '../../repositories/contacts/contact_repository.dart';

class UpdateContact implements Usecase<int, ContactParams> {
  final ContactRepository repository;

  const UpdateContact({
    required this.repository,
  });


  @override
  Future<Either<Failure, int>> call(ContactParams params) async {
    return await repository.updateContact(contact: params.contactItem);
  }
}