// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/api.dart' as _i6;
import '../ui/cubit/auth_cubit.dart' as _i7;
import '../utils/token_interceptor.dart' as _i5;
import 'app_module.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.Dio>(() => appModule.createDio);
  gh.lazySingleton<_i4.FlutterSecureStorage>(() => appModule.storage);
  gh.lazySingleton<_i5.TokenInterceptor>(() => appModule.tokenInterceptor);
  gh.singleton<_i6.Api>(_i6.Api(get<_i3.Dio>()));
  gh.factory<_i7.AuthCubit>(() => _i7.AuthCubit(get<_i6.Api>()));
  return get;
}

class _$AppModule extends _i8.AppModule {}
