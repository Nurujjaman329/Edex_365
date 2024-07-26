part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final AuthenticatedResponse auth;
  const Authenticated(this.auth);
  @override
  List<Object> get props => [auth];
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
  @override
  List<Object> get props => [];
}
