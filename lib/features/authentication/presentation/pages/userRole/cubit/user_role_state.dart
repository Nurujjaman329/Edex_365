part of 'user_role_cubit.dart';

abstract class UserRoleState extends Equatable {
  const UserRoleState();
}

class UserRoleInitial extends UserRoleState {
  @override
  List<Object> get props => [];
}

class UserRoleLoading extends UserRoleState {
  @override
  List<Object> get props => [];
}

class UserRoleLoaded extends UserRoleState {
  final List<UserRoles> userRoles;

  const UserRoleLoaded(this.userRoles);

  @override
  List<Object> get props => [userRoles];
}

class UserRoleError extends UserRoleState {
  @override
  List<Object> get props => [];
}
