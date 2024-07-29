import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';
import 'package:equatable/equatable.dart';

class UserRolesListResponse extends Equatable {
  final List<UserRoles> role;

  const UserRolesListResponse({
    required this.role,
  }) : super();

  @override
  List<Object> get props => [role];
}