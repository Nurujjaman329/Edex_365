import '../../domain/entities/authenticated_reponse.dart';


class AuthenticatedResponseModel extends AuthenticatedResponse {
  final String id;
  final String name;
  final String email;
  final String type;
  final String token;

  AuthenticatedResponseModel(
      {required this.id,
        required this.name,
        required this.email,
        required this.type,
        required this.token})
      : super(
    id: id,
    name: name,
    email: email,
    type: type,
    token: token,
  );

  factory AuthenticatedResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthenticatedResponseModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      type: json['type'],
      token: json['token'],
    );
  }
}
