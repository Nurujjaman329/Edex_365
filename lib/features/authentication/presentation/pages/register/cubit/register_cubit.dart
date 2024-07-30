import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/authenticated_reponse.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/sign_up_details.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/entities/registration_response.dart';
import '../../../../domain/usecases/post_register.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final PostRegister _postRegister;
  RegisterCubit(this._postRegister) : super(const RegisterInitial());

  Future<void> postRegister(SignUpDetails signUpDetails) async {
    emit(const RegisterLoading());

    final Either<Failure, RegistrationResponse> auth =
    await _postRegister(signUpDetails);

    auth.fold((failure) {
      emit(const RegisterError("Something Wrong"));
    }, (authenticated) {
      emit(RegisterSuccessful(authenticated));
    });
  }



}
