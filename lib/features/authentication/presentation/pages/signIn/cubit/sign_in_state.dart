part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  const SignInInitial();
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  const SignInLoading();
  @override
  List<Object> get props => [];
}

class SignInSuccessful extends SignInState {
  final AuthenticatedResponse auth;
  const SignInSuccessful(this.auth);
  @override
  List<Object> get props => [];
}

class SignInError extends SignInState {
  final String message;
  const SignInError(this.message);
  @override
  List<Object> get props => [message];
}
