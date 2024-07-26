class ServerException implements Exception {}

class AuthException implements Exception {}

class InputException implements Exception {
  final String message;
  InputException(this.message) : super();
}
