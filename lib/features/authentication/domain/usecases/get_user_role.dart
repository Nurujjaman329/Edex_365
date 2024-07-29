import 'package:dartz/dartz.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user_roles_response_model.dart';
import '../repositories/authentication_repository.dart';

class GetUserRoles {
  late final AuthenticationRepository repository;

  GetUserRoles(this.repository);

  @override
  Future<Either<Failure, UserRolesListResponseModel>> call() async {
    return await repository.getUsersRole();
  }
}