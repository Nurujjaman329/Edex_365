



import 'package:edex_3_6_5/features/authentication/domain/entities/sign_up_details.dart';
import 'package:equatable/equatable.dart';

class RegistrationResponse extends Equatable {

final String message;
final SignUpDetails signupDetails;


  RegistrationResponse({required this.message,required this.signupDetails,});

  @override
  List<Object> get props => [];

Map<String, dynamic> toJson() {
  return {'message': message,  'signupDetails': signupDetails};
}

}