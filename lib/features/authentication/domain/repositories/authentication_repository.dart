import 'package:dartz/dartz.dart';


import '../../../../core/error/failures.dart';
import '../entities/authenticated_reponse.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticatedResponse>> postLogin(String email, String password);
  Future<Either<Failure, AuthenticatedResponse>> getAuth();
  Future<void> setAuth(AuthenticatedResponse auth);
  Future<void> clearAuth();
}
