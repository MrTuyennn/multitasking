// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:multitasking/data/repositories/auth_repository_impl.dart'
    as _i965;
import 'package:multitasking/domain/repositories/auth_repository.dart' as _i839;
import 'package:multitasking/domain/usecases/login_usecase.dart' as _i251;
import 'package:multitasking/presentation/pages/auth/login/bloc/login_bloc.dart'
    as _i1005;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i839.AuthRepository>(() => _i965.AuthRepositoryImpl());
    gh.factory<_i251.LoginUsecase>(
      () => _i251.LoginUsecase(gh<_i839.AuthRepository>()),
    );
    gh.factory<_i1005.LoginBloc>(
      () => _i1005.LoginBloc(gh<_i251.LoginUsecase>()),
    );
    return this;
  }
}
