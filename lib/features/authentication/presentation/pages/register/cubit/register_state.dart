part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
  @override
  List<Object> get props => [];
}

class RegisterSuccessful extends RegisterState {
  final RegistrationResponse auth;
  const RegisterSuccessful(this.auth);
  @override
  List<Object> get props => [];
}

class RegisterError extends RegisterState {
  final String message;
  const RegisterError(this.message);
  @override
  List<Object> get props => [message];
}
