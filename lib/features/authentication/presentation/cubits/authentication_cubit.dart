import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/HttpManager.dart';
import '../../domain/entities/authenticated_reponse.dart';
import '../../domain/usecases/clear_auth_local.dart';
import '../../domain/usecases/get_auth_local.dart';
import '../../domain/usecases/set_auth_local.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final GetAuthLocal _getAuthLocal;
  final SetAuthLocal _setAuthLocal;
  final ClearAuthLocal _clearAuthLocal;

  //final HttpManager httpManager = sl<HttpManager>();

  AuthenticationCubit(
      this._getAuthLocal, this._setAuthLocal, this._clearAuthLocal)
      : super(const Unauthenticated());

  Future<void> getAuth() async {
    final Either<Failure, AuthenticatedResponse> auth = await _getAuthLocal();

    auth.fold((failure) {
      emit(const Unauthenticated());
    }, (authenticated) {
      HttpManager.token = authenticated.token;
      emit(Authenticated(authenticated));
    });
  }

  Future<void> setAuth(AuthenticatedResponse auth) async {
    await _setAuthLocal(auth);
    HttpManager.token = auth.token;
    emit(Authenticated(auth));
    return;
  }

  Future<void> signOut() async {
    await _clearAuthLocal();
    HttpManager.token = '';
    emit(const Unauthenticated());
    return;
  }
}
