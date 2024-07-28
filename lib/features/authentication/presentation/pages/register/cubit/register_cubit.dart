import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/entities/registration_response.dart';
import '../../../../domain/usecases/post_register.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final PostRegister _postRegister;
  RegisterCubit(this._postRegister) : super(const RegisterInitial());

  Future<void> postRegister(String name, String mobileNo, String password) async {
    emit(const RegisterLoading());

    final Either<Failure, RegistrationResponse> auth =
    await _postRegister(name: name, mobileNo: mobileNo, password: password);

    auth.fold((failure) {
      emit(const ResgisterError("Phone number already taken"));
    }, (authenticated) {
      emit(ResgisterSuccessful(authenticated));
    });
  }
}
