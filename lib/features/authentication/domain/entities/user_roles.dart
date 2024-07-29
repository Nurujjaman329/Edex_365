import 'package:equatable/equatable.dart';

class UserRoles extends Equatable {
  final String id;
  final String rName;

  UserRoles({ required this.id, required this.rName});

  @override
  List<Object> get props => [];


  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'rName': rName,
    };
  }

}