import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../entities/authenticated_reponse.dart';
import '../repositories/authentication_repository.dart';


// TODO: implement [UseCase] and overrride call method
class SetAuthLocal {
  final AuthenticationRepository repository;

  SetAuthLocal(this.repository);

  Future<void> call(AuthenticatedResponse auth) async {
    return await repository.setAuth(auth);
  }
}
