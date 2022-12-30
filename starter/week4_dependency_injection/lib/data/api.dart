import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:week4_dependency_injection/models/api_response.dart';
import 'package:week4_dependency_injection/models/user.dart';
part 'api.g.dart';

@RestApi()
@singleton
abstract class Api {
  @factoryMethod
  factory Api(Dio dio) = _Api;

  @POST('/user/login')
  @FormUrlEncoded()
  Future<ApiResponse<User?>> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}
