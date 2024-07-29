import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles_response.dart';
import 'package:edex_3_6_5/features/authentication/domain/usecases/get_user_role.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';

part 'user_role_state.dart';

class UserRoleCubit extends Cubit<UserRoleState> {
  final GetUserRoles _getUserRoles;
  List<UserRoles> userRoles = [];

  UserRoleCubit(this._getUserRoles) : super(UserRoleInitial());

  Future<void> getList() async {
    emit(UserRoleLoading()); // Emit loading state
    final Either<Failure, UserRolesListResponse> response = await _getUserRoles();

    response.fold((failure) {
      emit(UserRoleError());
    }, (body) {
      userRoles = body.role;
      emit(UserRoleLoaded(userRoles));
    });
  }
}
