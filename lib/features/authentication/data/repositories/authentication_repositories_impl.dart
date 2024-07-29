import 'package:dartz/dartz.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';
import 'package:meta/meta.dart';



import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/authenticated_reponse.dart';
import '../../domain/entities/registration_response.dart';
import '../../domain/entities/sign_up_details.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_local_data_sources.dart';
import '../datasources/authentication_remote_data_sources.dart';
import '../models/authenticated_response_model.dart';
import '../models/user_roles_response_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository  {

  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;

  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource
  });

  @override
  Future<Either<Failure, AuthenticatedResponse>> postLogin(String email, String password) async {
    try{
      final response = await remoteDataSource.postLogin(email, password);
      return Right(response);
    } on AuthException {
      return Left(AuthFailure());
    } on ServerException {
      return Left(ServerFailure());
    }  on InputException catch(inputError) {
      return Left(InputFailure(inputError.message));
    }

  }

  @override
  Future<Either<Failure, AuthenticatedResponse>> getAuth() async {
    try{
      final response = await localDataSource.getAuth();
      return Right(response);
    } on AuthException {
      return Left(AuthFailure());
    } catch(e) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<void> setAuth(AuthenticatedResponse auth) async {
    await localDataSource.setAuth(auth);
  }

  @override
  Future<void> clearAuth() async {
    await localDataSource.clearAuth();
  }



  @override
  Future<Either<Failure, RegistrationResponse>> postRegister(
      SignUpDetails signUpDetails) async {
    try {
      final response =
      await remoteDataSource.postRegister(signUpDetails);
      return Right(response);
    } on AuthException {
      return Left(AuthFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on InputException catch (inputError) {
      return Left(InputFailure(inputError.message));
    }
  }


  @override
  Future<Either<Failure, UserRolesListResponseModel>>
  getUsersRole() async {
    try {
      final response = await remoteDataSource.getUsersRole();
      return Right(response);
    } on AuthException {
      return Left(AuthFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
