import 'package:equatable/equatable.dart';

class AuthenticatedResponse extends Equatable {
  final String id;
  final String name;
  final String email;
  final String type;
  final String token;

  AuthenticatedResponse(
      {required this.id,
        required this.name,
        required this.email,
        required this.type,
        required this.token});

  @override
  List<Object> get props => [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'type': type,
      'token': token,
    };
  }
}
