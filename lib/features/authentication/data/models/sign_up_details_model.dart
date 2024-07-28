import 'package:edex_3_6_5/features/authentication/data/models/user_roles_model.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/sign_up_details.dart';

class SignUpDetailsModel extends SignUpDetails{

  final String name;
  final String mobileNo;
  final bool status;
  final String email;
  final String password;
  final DateTime? dob;
  final String school;
  final String sClass;
  final List<UserRolesModel> role;



  SignUpDetailsModel({required this.name,required this.mobileNo, required this.status, required this.email,required this.password,required this.dob, required this.school,required this.sClass,required this.role}):super(name: name,mobileNo: mobileNo,dob: dob,status: status,email: email,password: password,school: school,sClass: sClass,role: role);


  factory SignUpDetailsModel.fromJson(Map<String, dynamic> json) {
    return SignUpDetailsModel(
      name: json['name'],
      mobileNo: json['mobileNo'],
      status: json['status'],
      email: json['email'],
      password: json['password'],
      dob: json['dob'] != null
          ? DateTime.parse(json['dob'])
          : null,
      school: json['school'],
      sClass: json['sClass'],
      role: (json['role'] as List).map((tJson)=>UserRolesModel.fromJson(tJson)).toList(),
    );
  }
}