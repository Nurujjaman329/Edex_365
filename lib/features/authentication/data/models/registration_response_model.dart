


import 'package:edex_3_6_5/features/authentication/data/models/sign_up_details_model.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/registration_response.dart';

import '../../domain/entities/sign_up_details.dart';

class RegistrationResponseModel extends RegistrationResponse{

final String message;
final SignUpDetails signupDetails;



  RegistrationResponseModel({required this.message,required this.signupDetails, }):super(message: message,  signupDetails: signupDetails,);


  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseModel(
      message: json['message'],
      signupDetails: SignUpDetailsModel.fromJson(json['signupDetails']),
    );
  }


}