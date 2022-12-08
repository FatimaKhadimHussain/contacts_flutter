import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/contacts/contact_item.dart';
import '../../repositories/contacts/contact_repository.dart';

class GetFavoriteContacts implements Usecase<List<Contact>, NoParams>{
  final ContactRepository repository;

  const GetFavoriteContacts({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Contact>>> call(NoParams params) async {
    return await repository.loadFavoriteContacts();
  }
}