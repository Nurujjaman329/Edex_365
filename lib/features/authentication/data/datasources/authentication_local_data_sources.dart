import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/authenticated_reponse.dart';
import '../models/authenticated_response_model.dart';

abstract class AuthenticationLocalDataSource {
  /// get auth object from shared preferences.
  ///
  /// Throws a [AuthException] if not found.
  Future<AuthenticatedResponse> getAuth();

  /// get auth object from shared preferences.
  ///
  /// Throws a [CacheException] if not found.
  Future<void> setAuth(AuthenticatedResponse auth);

  /// clear auth object from shared preferences.
  ///
  /// Throws a [CacheException] if not found.
  Future<void> clearAuth();
}


class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;


  AuthenticationLocalDataSourceImpl({required this.sharedPreferences});

  final String cacheKey = 'megha_auth';

  @override
  Future<AuthenticatedResponseModel> getAuth() {
    final jsonString = sharedPreferences.getString(cacheKey);
    if (jsonString != null) {
      Map<String,dynamic> json = jsonDecode(jsonString);
      return Future.value(AuthenticatedResponseModel.fromJson(json));
    } else {
      throw AuthException();
    }
  }

  @override
  Future<void> setAuth(AuthenticatedResponse auth) {
    return sharedPreferences.setString(
      cacheKey,
      json.encode(auth.toJson()),
    );

  }

  @override
  Future<void> clearAuth() {
    return sharedPreferences.clear();
  }
}
