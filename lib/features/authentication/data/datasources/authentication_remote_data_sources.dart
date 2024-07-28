import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/HttpManager.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/authenticated_reponse.dart';
import '../../domain/entities/registration_response.dart';
import '../models/authenticated_response_model.dart';
import '../models/registration_response_model.dart';


abstract class AuthenticationRemoteDataSource {
  /// POST request to login api endpoint.
  ///
  /// Throws a [AuthException] for 404 error code (credentials mismatch).
  /// Or Throws a [ServerException] for all error codes.
  Future<AuthenticatedResponse> postLogin(String email, String password);

  /// POST request to login register endpoint.
  ///
  /// Throws a [InputException] for 400 error code.
  /// Or Throws a [ServerException] for all error codes.
  Future<RegistrationResponse> postRegister(
      String name, String mobileNo, String password);
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Dio client = sl<HttpManager>().client;

  AuthenticationRemoteDataSourceImpl();

  @override
  Future<AuthenticatedResponseModel> postLogin(
      String email, String password) async {
    try {
      final response = await client.post(
        '/api/Auth/Login',
        data:
        jsonEncode(<String, String>{'email': email, 'password': password}),
      );
      return AuthenticatedResponseModel.fromJson(
          response.data as Map<String, dynamic>);
    } catch (error) {
      log('Error');
      log(error.toString());
      String message = "Invalid Input";
      throw InputException(message);
    }







    //final response = await client.post('/v1/auth/login',
    //  data: jsonEncode(<String, String>{
    //    'email': email,
    //    'password': password
    //  }),
    //);

    //switch(response.statusCode){
    //  case 200 :
    //    return AuthenticatedResponseModel.fromJson(response.data as Map<String,dynamic>);
    //  case 404:
    //    throw AuthException();
    //  case 400:
    //    throw InputException("Input Error");
    //  default:
    //    throw ServerException();
    //}
  }


  @override
  Future<RegistrationResponseModel> postRegister(
      String name, String mobileNo, String password) async {
    try {
      final response = await client.post(
        '/api/Auth/Signup',
        data: jsonEncode(<String, String>{
          'name': name,
          'mobileNo': mobileNo,
          'password': password
        }),
      );
      switch (response.statusCode) {
        case 200:
          return RegistrationResponseModel.fromJson(
              response.data as Map<String, dynamic>);
        case 404:
          throw AuthException();
        case 400:
          throw InputException("Input Error");
        default:
          throw ServerException();
      }
    } catch (error) {
      // log((error as DioError).response?.data.toString() ?? "Nothing");
      log(error.toString());
      throw ServerException();
    }
  }


}
