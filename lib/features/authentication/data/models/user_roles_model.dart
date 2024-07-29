import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';

class UserRolesModel extends UserRoles{
  final String id;
  final String rName;

  UserRolesModel({required this.id, required this.rName}):super( id:id, rName: rName);


  factory UserRolesModel.fromJson(Map<String, dynamic> json) {
    return UserRolesModel(  id: json['id'] as String,   rName: json['rName'] as String,);
  }
}