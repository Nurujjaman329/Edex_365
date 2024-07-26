import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/authenticated_reponse.dart';
import '../repositories/authentication_repository.dart';


class GetAuthLocal implements UseCase<AuthenticatedResponse> {
  final AuthenticationRepository repository;

  GetAuthLocal(this.repository);

  Future<Either<Failure, AuthenticatedResponse>> call() async {
    return await repository.getAuth();
  }
}
