import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/registration_response.dart';
import '../entities/sign_up_details.dart';
import '../repositories/authentication_repository.dart';



class PostRegister {
  final AuthenticationRepository repository;

  PostRegister(this.repository);

  @override
  Future<Either<Failure, RegistrationResponse>> call(SignUpDetails signUpDetails) async {
    return await repository.postRegister(signUpDetails);
  }
}







