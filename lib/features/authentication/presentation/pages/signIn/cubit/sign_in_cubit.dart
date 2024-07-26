import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';


import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/entities/authenticated_reponse.dart';
import '../../../../domain/usecases/post_login.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final PostLogin _postLogin;
  SignInCubit(this._postLogin) : super(const SignInInitial());

  Future<void> postLogin(String email, String password) async {

    emit(const SignInLoading());

    final Either<Failure, AuthenticatedResponse> auth = await _postLogin(
        email: email, password: password);

    auth.fold(
            (failure) {
          emit(const SignInError("Incorrect Password"));
        },
            (authenticated) {
          emit(SignInSuccessful(authenticated));
        }
    );

  }
}
