import 'package:json_annotation/json_annotation.dart';
part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  @JsonKey(defaultValue: 0)
  final int status;

  @JsonKey(defaultValue: 'message')
  final String message;

  @JsonKey(name: 'error')
  final String? error;

  final T? data;

  @JsonKey(name: 'token')
  final String? token;

  ApiResponse({
    required this.status,
    required this.message,
    this.error,
    this.data,
    this.token,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$ApiResponseToJson(this, toJsonT);
}
