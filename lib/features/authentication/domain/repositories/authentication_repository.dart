import 'package:dartz/dartz.dart';


import '../../../../core/error/failures.dart';
import '../entities/authenticated_reponse.dart';
import '../entities/registration_response.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticatedResponse>> postLogin(String email, String password);
  Future<Either<Failure, AuthenticatedResponse>> getAuth();
  Future<void> setAuth(AuthenticatedResponse auth);
  Future<void> clearAuth();

  Future<Either<Failure, RegistrationResponse>> postRegister(String name, String mobileNo, String password
      );
}
