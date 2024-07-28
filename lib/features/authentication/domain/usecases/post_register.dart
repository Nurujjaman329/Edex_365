import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/registration_response.dart';
import '../repositories/authentication_repository.dart';

class PostRegister implements UseCase<RegistrationResponse> {
  final AuthenticationRepository repository;

  PostRegister(this.repository);

  @override
  Future<Either<Failure, RegistrationResponse>> call(
  { String name = '',
    String mobileNo = '',
    String password = '',}
  ) async {
    return await repository.postRegister(name,mobileNo,password);
  }
}
