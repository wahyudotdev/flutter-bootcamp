import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(name: json['name'], email: json['email']);
}
