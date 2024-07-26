import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/authenticated_reponse.dart';
import '../repositories/authentication_repository.dart';


class PostLogin implements UseCase<AuthenticatedResponse> {
  final AuthenticationRepository repository;

  PostLogin(this.repository);

  @override
  Future<Either<Failure, AuthenticatedResponse>> call({
    String email = '',
    String password = '',
  }) async {
    return await repository.postLogin(email,password);
  }
}
