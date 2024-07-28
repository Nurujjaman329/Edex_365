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

class ResgisterSuccessful extends RegisterState {
  final RegistrationResponse auth;
  const ResgisterSuccessful(this.auth);
  @override
  List<Object> get props => [];
}

class ResgisterError extends RegisterState {
  final String message;
  const ResgisterError(this.message);
  @override
  List<Object> get props => [message];
}
