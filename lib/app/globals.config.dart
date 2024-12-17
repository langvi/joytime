// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypt_shared_preferences/provider.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../bloc/common/common_cubit.dart' as _i5;
import '../data/api/auth_api_service.dart' as _i13;
import '../data/di/di.dart' as _i15;
import '../data/preference/app_preferences.dart' as _i12;
import '../data/repository/auth_repository.dart' as _i14;
import '../navigation/app_navigator.dart' as _i10;
import '../navigation/app_navigator_iml.dart' as _i11;
import '../routes/app_routes.dart' as _i4;
import '../ui/home/cubit/home_cubit.dart' as _i7;
import '../ui/sign_in/cubit/sign_in_cubit.dart' as _i9;
import 'app_cubit.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final serviceModule = _$ServiceModule();
    gh.factory<_i3.AppCubit>(() => _i3.AppCubit());
    gh.lazySingleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.factory<_i5.CommonCubit>(() => _i5.CommonCubit());
    await gh.factoryAsync<_i6.EncryptedSharedPreferences>(
      () => serviceModule.encryptPrefs,
      preResolve: true,
    );
    gh.factory<_i7.HomeCubit>(() => _i7.HomeCubit());
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => serviceModule.prefs,
      preResolve: true,
    );
    gh.factory<_i9.SignInCubit>(() => _i9.SignInCubit());
    gh.lazySingleton<_i10.AppNavigator>(
        () => _i11.AppNavigatorImpl(gh<_i4.AppRouter>()));
    gh.lazySingleton<_i12.AppPreferences>(() => _i12.AppPreferences(
          gh<_i8.SharedPreferences>(),
          gh<_i6.EncryptedSharedPreferences>(),
        ));
    gh.lazySingleton<_i13.AuthApiService>(
        () => _i13.AuthApiService(gh<_i12.AppPreferences>()));
    gh.lazySingleton<_i14.AuthRepository>(
        () => _i14.AuthRepository(gh<_i12.AppPreferences>()));
    return this;
  }
}

class _$ServiceModule extends _i15.ServiceModule {}
