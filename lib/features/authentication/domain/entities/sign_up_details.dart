import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';
import 'package:equatable/equatable.dart';

class SignUpDetails extends Equatable {

  final String name;
  final String mobileNo;
  final bool status;
  final String email;
  final String password;
  final DateTime? dob;
  final String school;
  final String sClass;
  final List<String> role;


  SignUpDetails({required this.name,required this.mobileNo, required this.status, required this.email,required this.password,required this.dob, required this.school,required this.sClass,required this.role}): super();

  @override
  List<Object> get props => [];

  Map<String , dynamic > toJson(){
    return {'name': name,
      'mobileNo' : mobileNo,
      'status':status,
      'email':email,
      'password':password,
      'dob':dob?.toIso8601String(),
      'school':school,
      'sClass': sClass,
      'role': role,
    };
  }
}