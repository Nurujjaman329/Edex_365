abstract class Failure {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {}

class AuthFailure extends Failure {}

class InputFailure extends Failure {
  final String message;
  InputFailure(this.message) : super();
}
