// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:multitasking/core/di/di_module.dart' as _i87;
import 'package:multitasking/data/datasources/preference/shared_preference.dart'
    as _i614;
import 'package:multitasking/data/datasources/remote/api_service.dart' as _i281;
import 'package:multitasking/data/datasources/remote/fcm_handler.dart' as _i481;
import 'package:multitasking/data/datasources/remote/fcm_service.dart' as _i838;
import 'package:multitasking/data/repositories/auth_repository_impl.dart'
    as _i965;
import 'package:multitasking/data/repositories/notification_repository_impl.dart'
    as _i384;
import 'package:multitasking/domain/repositories/auth_repository.dart' as _i839;
import 'package:multitasking/domain/repositories/notification_repository.dart'
    as _i236;
import 'package:multitasking/domain/usecases/login_usecase.dart' as _i251;
import 'package:multitasking/presentation/bloc/translate/translate_cubit.dart'
    as _i365;
import 'package:multitasking/presentation/pages/auth/login/bloc/login_bloc.dart'
    as _i1005;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diModule = _$DiModule();
    gh.factory<_i365.TranslateCubit>(() => _i365.TranslateCubit());
    gh.lazySingleton<_i838.FcmService>(() => diModule.fcmService);
    gh.lazySingleton<_i481.FcmHandler>(() => diModule.fcmHandler);
    await gh.lazySingletonAsync<_i558.FlutterSecureStorage>(
      () => diModule.secureStorage(),
      preResolve: true,
    );
    gh.lazySingleton<_i839.AuthRepository>(() => _i965.AuthRepositoryImpl());
    gh.factory<String>(() => diModule.baseUrl(), instanceName: 'baseUrl');
    gh.lazySingleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => diModule.navigatorKey(),
      instanceName: 'navigatorKey',
    );
    gh.lazySingleton<_i614.SharedPreference>(
      () => _i614.SharedPreference(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i236.NotificationRepository>(
      () => _i384.NotificationRepositoryImpl(gh<_i838.FcmService>()),
    );
    gh.factory<_i251.LoginUsecase>(
      () => _i251.LoginUsecase(gh<_i839.AuthRepository>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => diModule.dio(
        gh<_i614.SharedPreference>(),
        gh<_i409.GlobalKey<_i409.NavigatorState>>(instanceName: 'navigatorKey'),
      ),
    );
    gh.factory<_i1005.LoginBloc>(
      () => _i1005.LoginBloc(gh<_i251.LoginUsecase>()),
    );
    gh.lazySingleton<_i281.ApiService>(
      () => _i281.ApiService(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ),
    );
    return this;
  }
}

class _$DiModule extends _i87.DiModule {}
