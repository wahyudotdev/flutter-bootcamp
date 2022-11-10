import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:week4_dependency_injection/di/injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => $initGetIt(getIt);
