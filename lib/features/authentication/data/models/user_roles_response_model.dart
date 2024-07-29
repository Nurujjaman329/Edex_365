


import 'package:edex_3_6_5/features/authentication/data/models/user_roles_model.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles_response.dart';

class UserRolesListResponseModel extends UserRolesListResponse {
  final List<UserRolesModel> role;

  UserRolesListResponseModel({required this.role}):super(role: role);

  factory UserRolesListResponseModel.fromJson(List<dynamic> json) {
    return UserRolesListResponseModel(
      role: json.map((e) => UserRolesModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}