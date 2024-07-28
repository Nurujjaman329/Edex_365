import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';

class UserRolesModel extends UserRoles{

  final String rName;

  UserRolesModel({required this.rName}):super(rName: rName);


  factory UserRolesModel.fromJson(Map<String, dynamic> json) {
    return UserRolesModel(rName: json['rName'],);
  }
}