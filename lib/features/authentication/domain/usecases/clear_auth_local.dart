import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../repositories/authentication_repository.dart';


// TODO: implement [UseCase] and overrride call method
class ClearAuthLocal {
  final AuthenticationRepository repository;

  ClearAuthLocal(this.repository);

  Future<void> call() async {
    return await repository.clearAuth();
  }
}
