import 'package:dartz/dartz.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';


import '../../../../core/error/failures.dart';
import '../../data/models/user_roles_response_model.dart';
import '../entities/authenticated_reponse.dart';
import '../entities/registration_response.dart';
import '../entities/sign_up_details.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticatedResponse>> postLogin(String email, String password);
  Future<Either<Failure, AuthenticatedResponse>> getAuth();
  Future<void> setAuth(AuthenticatedResponse auth);
  Future<void> clearAuth();

  Future<Either<Failure, RegistrationResponse>> postRegister(SignUpDetails signUpDetails);

  Future<Either<Failure , UserRolesListResponseModel>>getUsersRole();
}
